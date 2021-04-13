Rails.application.routes.draw do
  devise_for :admin_devises
  devise_for :admins
  namespace :admin do
    root to: 'homes#top'
  end
end
