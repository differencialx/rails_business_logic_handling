RSpec.shared_examples 'cats update' do |type|
  let(:make_request) do
    put "/business_logic/#{type}/cats/#{id}", params: params, as: :json
  end
  let(:cat) { create(:cat) }
  let(:cat_attrs) { attributes_for(:cat) }
  let(:id) { cat.id }
  let(:name) { cat_attrs[:name] }
  let(:weight) { cat_attrs[:weight] }
  let(:age) { cat_attrs[:age] }
  let(:breed) { cat_attrs[:breed] }
  let(:params) do
    {
      name: name,
      breed: breed,
      age: age,
      weight: weight
    }
  end
  let(:response_status) { 200 }
  let(:file_name) { 'http://images.com/stub' }
  let(:response_body) { { 'file' => file_name }.to_json }
  let(:response_double) do
    instance_double(
      'Faraday::Response',
      status: response_status,
      body: response_body
    )
  end

  before do
    allow(Faraday).to receive(:get)
      .and_return(response_double)
    cat
  end

  shared_examples 'renders error' do |status:, message:|
    it "returns #{status}" do
      make_request
      expect(response.status).to eq status
      parsed_response = JSON(response.body)
      expect(parsed_response).to eq [message]
    end
  end

  context 'when not found' do
    let(:id) { 'non_existing_id' }

    it_behaves_like 'renders error',
                    status: 404,
                    message: 'Record not found'
  end

  context 'when external service cal error' do

    before do
      allow(Faraday).to receive(:get)
        .and_raise(Timeout::Error, 'Request timeout')
    end

    it_behaves_like 'renders error',
                    status: 500,
                    message: 'Oops, something went wrong'
  end

  context 'when image request ended with failure status' do
    let(:response_status) { 400 }

    it_behaves_like 'renders error',
                    status: 503,
                    message: 'Fetch image error'
  end

  context 'when image request ended with failure status' do
    let(:file_name) { '' }

    it_behaves_like 'renders error',
                    status: 503,
                    message: 'We are experiencing image fetching issues, please try again later'
  end

  context 'when name is blank' do
    let(:name) { '' }

    it_behaves_like 'renders error',
                    status: 422,
                    message: "Name can't be blank"
  end

  context 'when name is nil' do
    let(:name) { nil }

    it_behaves_like 'renders error',
                    status: 422,
                    message: "Name can't be blank"
  end

  context 'when breed is blank' do
    let(:breed) { '' }

    it_behaves_like 'renders error',
                    status: 422,
                    message: "Breed can't be blank"
  end

  context 'when breed is nil' do
    let(:breed) { nil }

    it_behaves_like 'renders error',
                    status: 422,
                    message: "Breed can't be blank"
  end

  context 'when weight is less than 0' do
    let(:weight) { 0 }

    it_behaves_like 'renders error',
                    status: 422,
                    message: 'Weight must be greater than or equal to 1'
  end

  context 'when weight is not a number' do
    let(:weight) { 'not_a_number' }

    it_behaves_like 'renders error',
                    status: 422,
                    message: 'Weight is not a number'
  end

  context 'when age is less than 0' do
    let(:age) { 0 }

    it_behaves_like 'renders error',
                    status: 422,
                    message: 'Age must be greater than or equal to 1'
  end

  context 'when age is not a number' do
    let(:age) { 'not_a_number' }

    it_behaves_like 'renders error',
                    status: 422,
                    message: 'Age is not a number'
  end

  context 'when success' do
    it 'changes cat attributes' do
      make_request

      expect(response.status).to eq 200
      parsed_response = JSON(response.body)
      expect(parsed_response['data']['id']).to eq id
      expect(parsed_response['data']['name']).to eq "🐈 #{name} 🐈"
      expect(parsed_response['data']['breed']).to eq breed
      expect(parsed_response['data']['weightKg']).to eq weight
      expect(parsed_response['data']['weightLbs']).to eq (CatDecorator::TO_LBS * weight).to_i
      expect(parsed_response['data']['ageYears']).to eq age
      expect(parsed_response['data']['ageMonths']).to eq age * 12
      expect(parsed_response['data']['imageUrl']).to eq file_name
    end
  end
end
