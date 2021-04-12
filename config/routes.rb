Rails.application.routes.draw do
  namespace :admin do
    root to: 'homes#top'
  end
end
