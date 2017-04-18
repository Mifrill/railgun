Rails.application.routes.draw do
  get 'pages/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#root'

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  # authenticate :user do
  #   resources :users, only: [] do
  #     resource :reincarnation, only: :create
  #   end
  #   resource :reincarnation, only: :destroy
  # end

  # require 'sidekiq/web'
  # authenticate :user, lambda { |user| user.developer? } do
  #   mount Sidekiq::Web => '/staff/sidekiq'
  # end
end
