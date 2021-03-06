Rails.application.routes.draw do
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  get 'bulletins/:id/climbs' => 'bulletins#listclimbs'

  resources :users, only: [:index, :show]

  resources :gyms do
    resources :climbs, only: [:index, :create]
    # index, create
    resources :bulletins
  end
  resources :climbs, except: [:new, :edit, :index, :create]
  # show, update, destroy
  resources :favorites
end
