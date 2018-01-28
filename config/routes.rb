Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get "user/home"
    
    post "user/home" => "user#create"
    
    post "/" => "user#create"
    
    get "users/:username" => "user#show"
    
    root "user#home"
end
