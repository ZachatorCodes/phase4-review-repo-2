Rails.application.routes.draw do
  
  resources :reviews, except: [:show]
  resources :users, only: [:index, :create, :show]
  resources :movies

  get "/movies/:id", to: "movies#show"

  # Routing logic: fallback requests for React Router.
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/genrecount', to: 'movies#genrecount'

  # Leave this here to help deploy your app later!
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

  

end

# Create a custom route that grabs the top n (parameter sent back in the route) users based on the aggregate length of all the reviews they have written (based on review_content column). Render back the json of the user objects in an array, top user first. 



# Simpler version (based on number of reviews they have written)
# Harder version (create a custom method that returns the aggregate length of all the reviews a user has written)
