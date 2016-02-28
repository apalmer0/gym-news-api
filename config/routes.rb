Rails.application.routes.draw do
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'

  resources :users, only: [:index, :show] do
    resources :profiles
  end

  resources :gyms do
    resources :climbs, only: [:index, :create]
    # index, create
  end
  resources :climbs, except: [:new, :edit, :index, :create]
  # show, update, destroy
end
