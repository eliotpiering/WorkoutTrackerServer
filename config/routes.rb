Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #
  #

  get "/workouts", to: "workouts#index"
  get "/workouts/:id", to: "workouts#show"
  resources :programs
end
