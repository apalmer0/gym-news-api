class BulletinsController < ProtectedController
  before_filter :set_bulletin, only: [:show, :update, :destroy]
  before_filter :set_gym, only: [:index]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    # render json: Bulletin.all
    @bulletins = @gym.bulletins.order(created_at: :desc)

    render json: @bulletins
  end

  def listclimbs
    @bulletin = Bulletin.find(params[:id])
    @climbs = @bulletin.climbs
    render json: @climbs
  end

  def show
    render json: @bulletin
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)

    if @bulletin.save
      render json: @bulletin, status: :created
    else
      render json: @bulletin.errors, status: :unprocessable_entity
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      render json: @bulletin, status: :ok
    else
      render json: @bulletin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin.destroy
    head :no_content
  end


  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
  private :set_bulletin

  def bulletin_params
    params.require(:bulletin).permit(:content, :gym_id)
  end
  private :bulletin_params

private

  def set_gym
    @gym = Gym.find(params[:gym_id])
  end

end
