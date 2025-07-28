Rails.application.routes.draw do
  devise_for :users
  root "books#index"

  resources :books do
    member do
      patch :borrow
      patch :return_book
    end
  end

  resources :authors
  resources :members
  resources :borrowings do
    member do
      patch :mark_returned
      patch :mark_overdue
    end
  end

  # Custom routes for library operations
  get "library/dashboard", to: "books#dashboard"
  get "library/overdue", to: "borrowings#overdue"
  get "library/search", to: "books#search"
end
