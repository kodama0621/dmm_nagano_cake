Rails.application.routes.draw do
  get 'admins/search/search'
  root to: 'customers/homes#home'
  get 'home/about' => 'customers/homes#about'
  get 'customers/unsubscribe' => 'customers/customers#unsubscribe'
  patch 'customers/withdraw/:id' => 'customers/customers#withdraw' ,as:'customers_withdraw'
  delete 'cart_items/destroy_all' => 'customers/cart_items#destroy_all'
  post 'customers/orders/comfirm' => 'customers/orders#comfirm',as:'customers_order_comfirm'
  get 'customers/orders/complete' => 'customers/orders#complete',as:'customers_order_complete'
  get 'admins/homes/top' => 'admins/homes#top'
  patch 'admins/order_details/:id' => 'admins/order_products#update',as:'order_products'

  devise_for :customers, controllers: {
    sessions:      'customer_devises/sessions',
    passwords:     'customer_devises/passwords',
    registrations: 'customer_devises/registrations'
  }
  namespace :customers do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers ,:only => [:show, :edit,:update]
  resources :products ,:only => [:show,:index]
  resources :cart_items ,:only => [:index, :update, :create,:destroy]do
      delete "all_destroy"
  end
  resources :orders ,:only => [:index,:show,:new,:create]
  resources :shippings, :only => [:index,:edit,:create,:update,:destroy]
  end

  devise_for :admins, controllers: {
    sessions:      'admin_devises/sessions',
    passwords:     'admin_devises/passwords',
    registrations: 'admin_devises/registrations'
  }
  namespace :admins do
  resources :items, :only => [:index,:show,:new,:create,:edit,:update]
  resources :genres, :only => [:index,:create,:edit,:show,:update]
  resources :customers, :only => [:index,:show,:edit,:update]
  resources :orders, :only => [:index,:show,:update]
  end
end