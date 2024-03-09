Rails.application.routes.draw do
  root to: 'sessions#new'
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"
end
