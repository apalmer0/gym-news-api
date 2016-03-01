class FavoritesController < ProtectedController
  before_filter :set_favorite, only: [:show, :update, :destroy]
#
#   def index
#     puts "index"
#   end
#
#   def show
#     puts "show"
#   end
#
  def create
    @favorite = Favorite.new(favorite_params)

    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end
#
#   def update
#     puts "update"
#   end
#
#   def destroy
#     puts "destroy"
#   end
#
# private
#
#   def set_climb
#
#   end
#
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end
  private :set_favorite

  def favorite_params
    params.permit(:user_id, :climb_id)
  end
#
#   def edit_climb_params
#
#   end
end
