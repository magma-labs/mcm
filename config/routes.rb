# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'mcm' do
    get '*path', to: 'pages#show', constraints: ->(req) { Mcm::Page.find_by_route(req.path_info).exists? }

    namespace 'admin' do
      resources :locales
      resources :custom_pages do
        member { get :preview }
        resources :components do
          resources :components
          member { put :move_to }
        end
      end
    end
  end
end
