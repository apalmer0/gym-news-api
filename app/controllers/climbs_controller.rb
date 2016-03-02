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
    invalid_climb = false

    Climb.transaction do
      @climbs = Climb.create(climb_params)
      invalid_climb = @climbs.find { |climb| !climb.valid? }
      fail ActiveRecord::Rollback if invalid_climb
    end

    if !invalid_climb
      render json: @climbs, status: :created
    else
      render json: invalid_climb.errors, status: :unprocessable_entity
      # find the first broken instance, render its errors
    end
  end

  def update
    if @climb.update(edit_climb_params)
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
    params.permit(climbs: [:color, :climb_type, :grade, :modifier, :gym_id, :bulletin_id])[:climbs]
  end

  def edit_climb_params
    params.permit(:color, :climb_type, :grade, :modifier, :gym_id)
  end
end
