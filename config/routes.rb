Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }, skip: [ :registrations ]
  # カスタムルーティング
  devise_scope :user do
    get "users/character_form", to: "users/registrations#character_form", as: :character_form
    patch "users/character",      to: "users/registrations#update_character", as: :update_character
    get "users/sign_up", to: "users/registrations#new", as: :new_user_registration
    post "users", to: "users/registrations#create", as: :user_registration
    get "users/edit", to: "users/registrations#edit", as: :edit_user_registration
    put "users", to: "users/registrations#update"
    delete "users", to: "users/registrations#destroy"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "chats#index"
  delete "/chat_reset", to: "posts#reset_chat"
  get "conversation_history", to: "conversations#show_history"
  # 各種説明文
  get "calendar_description", to: "descriptions#calendar_description", as: :calendar_description
  get "how_character_selection", to: "descriptions#how_character_selection", as: :how_character_selection
  get "how_to_write", to: "descriptions#how_to_write", as: :how_to_write
  get "how_to_use", to: "descriptions#how_to_use", as: :how_to_use
  get "profile_setting", to: "descriptions#profile_setting", as: :profile_setting

  resources :chats, only: [ :index, :create ]
  resources :posts, only: [ :index, :show, :destroy ]
  resource :profile, only: [:show] do
    get :edit_name
    patch :update_name
    get :edit_avatar
    patch :update_avatar
  end
end
