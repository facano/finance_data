Rails.application.routes.draw do
  get 'main/home'
  get 'main/draw_report', as: :draw_report
  root to: "main#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
