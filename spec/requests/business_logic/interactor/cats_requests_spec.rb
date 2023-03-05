RSpec.describe 'Interactor cats' do
  it_behaves_like 'cats index', :interactor
  it_behaves_like 'cats update', :interactor
end
