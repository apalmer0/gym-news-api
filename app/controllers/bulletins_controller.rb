class BulletinsController < ProtectedController
  before_filter :set_bulletin, only: [:show, :update, :destroy]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Bulletin.all
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

end
