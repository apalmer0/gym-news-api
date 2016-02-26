class ClimbsController < ProtectedController
  before_filter :set_climb, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Climb.all
  end

  def show
    render json: @climb
  end

  def create
    @climb = Climb.new(climb_params)

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

  def set_climb
    @climb = Climb.find(params[:id])
  end
  private :set_climb

  def climb_params
    params.permit(:color, :grade, :modifier)
  end
  private :climb_params
end
