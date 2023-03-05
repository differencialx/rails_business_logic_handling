Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/' => 'previews#index'

  namespace :business_logic do
    %i[fat poro trailblazer interactor yaso decouplio].each do |type|
      namespace type do
        resources :cats, only: %i[index update] do
          get 'filters', :on => :collection
        end
      end
    end
  end
end
