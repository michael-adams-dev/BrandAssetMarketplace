Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "listings#index"
  resources :listings do
    member do
      patch :hide
      put :hide
    end
  end
  resources :seller_profiles
end
