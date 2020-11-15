Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "listings#index"
  resources :listings do
    resources :reviews, only: :create
    member do
      patch :hide
      put :hide
    end
  end
  resources :seller_profiles do
    resources :reviews, only: :create
  end
  get "/payments/success", to: "payments#success"
end
