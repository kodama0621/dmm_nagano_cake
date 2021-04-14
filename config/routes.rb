Rails.application.routes.draw do


  namespace :admin do
    get 'genres/edit'
    get 'genres/index'
    get 'genres/show'
  end
  devise_for :admins, controllers: {
    sessions: 'admin_devises/sessions',
    passwords: 'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }
  namespace :admin do
    root to: 'homes#top'
  end
end
