RSpec.shared_examples 'cats index' do |type|
  let(:make_request) do
    get "/business_logic/#{type}/cats", params: params, as: :json
  end
  let(:cats) { create_list(:cat, 5) }
  let(:page) { 1 }
  let(:items) { 2 }
  let(:params) do
    {
      page: page,
      items: items,
      **filter_params,
      **sort_options
    }.compact
  end
  let(:filter_params) { {} }
  let(:sort_options) { {} }

  context 'without filters' do
    before do
      cats
    end

    it 'returns response' do
      make_request
      expect(response.status).to eq 200
      parsed_response = JSON(response.body).with_indifferent_access
      expect(parsed_response[:pagy]).to have_key(:page)
      expect(parsed_response[:pagy]).to have_key(:last)
      expect(parsed_response[:data].size).to eq 2
    end
  end

  context 'when pagination' do
    before do
      cats
    end

    context 'when page 1' do
      it do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:pagy]).to have_key(:page)
        expect(parsed_response[:pagy]).to have_key(:last)
        expect(parsed_response[:data].size).to eq 2
      end

    end

    context 'when page 3' do
      let(:page) { 3 }
      it do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:pagy]).to have_key(:page)
        expect(parsed_response[:pagy]).to have_key(:last)
        expect(parsed_response[:data].size).to eq 1
      end
    end
  end

  context 'when filters' do
    context 'when breed' do
      let(:breed_1) { 'breed1' }
      let(:breed_2) { 'breed2' }
      let(:cat_1) { create(:cat, breed: breed_1) }
      let(:cat_2) { create(:cat, breed: breed_2) }
      let(:rest_of_cats) { create_list(:cat, 3) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { breed: [breed_1, breed_2] } }

      before do
        cat_1
        cat_2
        rest_of_cats
      end

      it 'returns only cat1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when age from' do
      let(:cat_1) { create(:cat, age: 4) }
      let(:cat_2) { create(:cat, age: 5) }
      let(:rest_of_cats) { create_list(:cat, 3, age: 3) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { age_from: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when age to' do
      let(:cat_1) { create(:cat, age: 4) }
      let(:cat_2) { create(:cat, age: 3) }
      let(:rest_of_cats) { create_list(:cat, 3, age: 5) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { age_to: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when age from and age to' do
      let(:cat_1) { create(:cat, age: 4) }
      let(:cat_2) { create(:cat, age: 3) }
      let(:rest_of_cats1) { create_list(:cat, 3, age: 5) }
      let(:rest_of_cats2) { create_list(:cat, 3, age: 2) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { age_from: 3, age_to: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats1
        rest_of_cats2
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when weight from' do
      let(:cat_1) { create(:cat, weight: 4) }
      let(:cat_2) { create(:cat, weight: 5) }
      let(:rest_of_cats) { create_list(:cat, 3, weight: 3) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { weight_from: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when weight to' do
      let(:cat_1) { create(:cat, weight: 4) }
      let(:cat_2) { create(:cat, weight: 3) }
      let(:rest_of_cats) { create_list(:cat, 3, weight: 5) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { weight_to: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end

    context 'when weight from and weight to' do
      let(:cat_1) { create(:cat, weight: 4) }
      let(:cat_2) { create(:cat, weight: 3) }
      let(:rest_of_cats1) { create_list(:cat, 3, weight: 5) }
      let(:rest_of_cats2) { create_list(:cat, 3, weight: 2) }
      let(:page) { 1 }
      let(:items) { 5 }
      let(:filter_params) { { weight_from: 3, weight_to: 4 } }

      before do
        cat_1
        cat_2
        rest_of_cats1
        rest_of_cats2
      end

      it 'returns cat 1 and cat 2' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 2
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat_1.id, cat_2.id]
      end
    end
  end

  context 'when sorting' do
    context 'when name asc' do
      let(:sort_options) { { sort: 'name' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, name: 'g') }
      let(:cat2) { create(:cat, name: 'a') }
      let(:cat3) { create(:cat, name: 'x') }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat2.id, cat1.id, cat3.id]
      end
    end

    context 'when name desc' do
      let(:sort_options) { { sort: '-name' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, name: 'g') }
      let(:cat2) { create(:cat, name: 'a') }
      let(:cat3) { create(:cat, name: 'x') }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat3.id, cat1.id, cat2.id]
      end
    end

    context 'when age asc' do
      let(:sort_options) { { sort: 'age' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, age: 3) }
      let(:cat2) { create(:cat, age: 1) }
      let(:cat3) { create(:cat, age: 5) }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat2.id, cat1.id, cat3.id]
      end
    end

    context 'when age desc' do
      let(:sort_options) { { sort: '-age' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, age: 3) }
      let(:cat2) { create(:cat, age: 1) }
      let(:cat3) { create(:cat, age: 5) }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat3.id, cat1.id, cat2.id]
      end
    end

    context 'when weight asc' do
      let(:sort_options) { { sort: 'weight' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, weight: 3) }
      let(:cat2) { create(:cat, weight: 1) }
      let(:cat3) { create(:cat, weight: 5) }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat2.id, cat1.id, cat3.id]
      end
    end

    context 'when weight desc' do
      let(:sort_options) { { sort: '-weight' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, weight: 3) }
      let(:cat2) { create(:cat, weight: 1) }
      let(:cat3) { create(:cat, weight: 5) }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat3.id, cat1.id, cat2.id]
      end
    end

    context 'when breed asc' do
      let(:sort_options) { { sort: 'breed' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, breed: 'g') }
      let(:cat2) { create(:cat, breed: 'a') }
      let(:cat3) { create(:cat, breed: 'x') }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat2.id, cat1.id, cat3.id]
      end
    end

    context 'when breed desc' do
      let(:sort_options) { { sort: '-breed' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, breed: 'g') }
      let(:cat2) { create(:cat, breed: 'a') }
      let(:cat3) { create(:cat, breed: 'x') }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 200
        parsed_response = JSON(response.body).with_indifferent_access
        expect(parsed_response[:data].size).to eq 3
        expect(parsed_response[:data].map{ |rec| rec[:id] }).to eq [cat3.id, cat1.id, cat2.id]
      end
    end

    context 'when invalid sort options' do
      let(:sort_options) { { sort: 'invalid_options' } }
      let(:page) { 1 }
      let(:items) { 5 }

      let(:cat1) { create(:cat, breed: 'g') }
      let(:cat2) { create(:cat, breed: 'a') }
      let(:cat3) { create(:cat, breed: 'x') }

      before do
        cat1
        cat2
        cat3
      end

      it 'return records in correct order' do
        make_request
        expect(response.status).to eq 400
        parsed_response = JSON(response.body)
        expect(parsed_response).to eq ['Sort invalid_options is not allowed']
      end
    end
  end
end
