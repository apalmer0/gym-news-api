class ProfilesController < ProtectedController
  before_filter :set_profile, only: [:show, :update, :destroy]
  before_filter :set_user, only: [:index, :create]
  skip_before_action :authenticate, only: [:index, :show]

  def index
    render json: Profile.all
  end

  def show
    render json: @profile
  end

  def create
    @profile = @user.build_profile(profile_params)
    @user = @profile.user

    if @profile.save
      render json: @profile, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      render json: @profile, status: :ok
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    head :no_content
  end

private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name)
  end
end
