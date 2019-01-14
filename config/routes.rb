Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  resources :dashboard, only: :index
  get :exercise_one, to: 'exercise_one#show'
  post :exercise_one, to: 'exercise_one#create'

  get :exercise_two, to: 'exercise_two#show'
  post :exercise_two, to: 'exercise_two#create'
  
  get :exercise_three, to: 'exercise_three#show'
  post :exercise_three, to: 'exercise_three#create'
end
