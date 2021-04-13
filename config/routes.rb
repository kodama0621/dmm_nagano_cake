Rails.application.routes.draw do
  get 'admins/search/search'
  get 'admins/homes/top' => 'admins/homes#top'
  devise_for :admins, controllers: {
    sessions: 'admin_devises/sessions',
    passwords: 'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }
  namespace :admin do
    root to: 'homes#top'
  end
end
