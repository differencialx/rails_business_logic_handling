RSpec.describe 'Trailblazer cats' do
  it_behaves_like 'cats index', :trailblazer
  it_behaves_like 'cats update', :trailblazer
end
