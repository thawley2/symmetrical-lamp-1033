Rails.application.routes.draw do

  get '/customers/:id', to: 'customers#show'
  post '/customers/:id', to: 'customer_items#create'
end
