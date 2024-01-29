# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'mcm' do
    get '*path', to: 'pages#show', constraints: ->(request) { Mcm::Page.active.find_by(path: request.path_info) }
    get '/preview/:path', to: 'pages#preview', as: :preview_page

    namespace 'admin' do
      resources :custom_pages do
        resources :components do
          resources :components
          member { put :move_to }
        end
        member { get :preview }
      end
    end
  end
end
