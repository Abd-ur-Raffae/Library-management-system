Rails.application.routes.draw do
  devise_for :users
  root "books#index"

  resources :books do
    member do
      patch :borrow
      patch :return_book
    end
    # Add this nested route for creating requests from book page
    resources :book_requests, only: [ :new, :create ]
  end

  resources :authors
  resources :members
  resources :borrowings do
    member do
      patch :mark_returned
      patch :mark_overdue
    end
  end

  # Add book requests routes
  resources :book_requests do
    member do
      patch :approve
      patch :reject
    end
  end

  # Custom routes for library operations
  get "library/dashboard", to: "books#dashboard"
  get "library/overdue", to: "borrowings#overdue"
  get "library/search", to: "books#search"

  # Add route for member's own requests
  get "my_requests", to: "book_requests#my_requests"
end
