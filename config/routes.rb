Karaharapriya::Application.routes.draw do

  root :to => "home#index"

  resources :ragams, :songs, :talams, :composers, :except => [:destroy]

  match "suggest/ragam" => "ragams#suggest", :as => "suggest_ragam"
  match "suggest/talam" => "talams#suggest", :as => "suggest_talam"
  match "suggest/composer" => "composers#suggest", :as => "suggest_composer"
end
