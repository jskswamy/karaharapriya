Karaharapriya::Application.routes.draw do

  root :to => "home#index"

  resources :ragams, :songs

  match "suggest/ragam" => "ragams#suggest", :as => "suggest_ragam"
  match "suggest/talam" => "talam#suggest", :as => "suggest_talam"
  match "suggest/composer" => "composer#suggest", :as => "suggest_composer"
end
