class GymsController < ProtectedController
  before_filter :set_gym, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Gym.all
  end

  def show
    render json: @gym
  end

  def create
    @gym = Gym.new(gym_params)

    if @gym.save
      render json: @gym, status: :created
    else
      render json: @gym.errors, status: :unprocessable_entity
    end
  end

  def update
    if @gym.update(gym_params)
      render json: @gym, status: :ok
    else
      render json: @gym.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @gym.destroy
    head :no_content
  end

  def set_gym
    @gym = Gym.find(params[:id])
  end
  private :set_gym

  def gym_params
    params.permit(:name, :city, :state)
  end
  private :gym_params
end
