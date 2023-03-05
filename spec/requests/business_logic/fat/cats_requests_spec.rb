RSpec.describe 'Fat cats' do
  it_behaves_like 'cats index', :fat
  it_behaves_like 'cats update', :fat
end
