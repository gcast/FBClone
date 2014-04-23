FBClone::Application.routes.draw do
 
  resources :users, only: [:new, :create, :show] do
  	resources :friend_requests, only: [:create]
  	resources :posts, only: [:create, :index]

  	member do
  		get 'friends'
  		get 'about'
  	end

  end
  resource :session, only: [:new, :create, :destroy]
  resources :friendships, only: [:destroy]

  # MAKE RESTFUL ??
  put "/friend_requests/:id/accept", { as: :accept_request, controller: :friend_requests, action: :accept }
  put "/friend_requests/:id/decline", { as: :decline_request, controller: :friend_requests, action: :decline }
  
  post "/posts/:post_id/comment", { as: :post_comment, controller: :comments, action: :create }
  post "/photos/:photo_id/comment", { as: :photo_comment, controller: :comments, action: :create }

end


