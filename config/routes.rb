Rails.application.routes.draw do
  root "alarms#index"
  resources :alarms
end
