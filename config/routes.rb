Rails.application.routes.draw do
  get 'games/new', to: 'games#new', as: :new
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'games/score', to: 'games#score', as: :score
end
