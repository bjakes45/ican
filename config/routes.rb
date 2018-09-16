Rails.application.routes.draw do
  
  root to: 'pages#index'
  
  get 'profile', to: 'pages#profile'  
  get 'user_council_posts', to: 'pages#council_posts'  
  get 'user_posts', to: 'pages#user_posts'  
  
  get 'councils/:id/settings', to: 'councils#settings', as: 'main_settings'  
  post 'councils/:council_id/posts/:id/comment', to: 'posts#comment'
  get 'deactivate_post', to: 'posts#deactivate' 
  
  get 'deactivate_mot_vote', to: 'mot_votes#deactivate' 
  
  get 'deactivate_pos_vote', to: 'pos_votes#deactivate' 
  get 'accept_pos_vote', to: 'pos_votes#accept' 
  get 'reject_pos_vote', to: 'pos_votes#reject' 
  
  get 'deactivate_member_req', to: 'memberships#deactivate'
  get 'deactivate_memb_vote', to: 'memb_votes#deactivate' 
  get 'councils/:council_id/pending_members' => 'memberships#pending', as: 'council_pending_members'

  get 'states/:country', to: 'application#states'
  get 'states/:country/cities/:state', to: 'application#cities'

  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end
  
  resources :councils do
    resources :council_settings
    resources :policies
    resources :posts do
      resources :mot_votes
    end
    resources :memberships do
      resources :memb_votes
    end
    resources :positions do
      resources :pos_votes
      resources :candidates, only: [:create]
    end
  end

  namespace :private do 
    resources :conversations, only: [:create] do
      member do
        post :close
      end
    end
    resources :messages, only: [:index, :create]
  end
end
