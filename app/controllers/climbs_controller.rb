class ClimbsController < ProtectedController
  before_filter :set_climb, only: [:show, :update, :destroy]
  before_filter :set_gym, only: [:index, :create]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    @climbs = @gym.climbs

    render json: @climbs
  end

  def show
    render json: @climb
  end

  def create
    @climb = Climb.new(climb_params)
    @climb.gym = @gym

    if @climb.save
      render json: @climb, status: :created
    else
      render json: @climb.errors, status: :unprocessable_entity
    end
  end

  def update
    if @climb.update(climb_params)
      render json: @climb, status: :ok
    else
      render json: @climb.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @climb.destroy
    head :no_content
  end

private

  def set_climb
    @climb = Climb.find(params[:id])
  end

  def set_gym
    @gym = Gym.find(params[:gym_id])
  end

  def climb_params
    params.require(:climb).permit(:color, :grade, :modifier)
  end
end
