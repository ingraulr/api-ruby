Rails.application.routes.draw do
  get 'welcome/index'
  resources :facturas 
  resources :empresas
  resources :comprobantes do
    post :timbrar
    post :cancelar
    post :enviar
    post :descargar
  end

  
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
