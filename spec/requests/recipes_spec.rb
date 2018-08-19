require 'rails_helper'

RSpec.describe 'Recipes API', type: :request do
  let!(:recipes) { create_list(:recipe, 10) }
  let(:recipe_id) { recipes.first.id }

  # Test suite for GET /api/recipes
  describe 'GET /api/recipes' do
    before { get '/api/recipes' }

    it 'returns recipes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/recipes/:id
  describe 'GET /api/recipes/:id' do
    before { get "/api/recipes/#{recipe_id}" }

    context 'when the record exists' do
      it 'returns the recipe' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(recipe_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:recipe_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  # Test suite for POST /api/recipes
  describe 'POST /api/recipes' do
    # valid payload
    let(:valid_attributes) { { title: 'Mashed Potatoes', steps: '1.Peel Potatos', ingredients: 'potatoes,salt' } }

    context 'when the request is valid' do
      before { post '/api/recipes', params: valid_attributes }

      it 'creates a recipe' do
        expect(json['title']).to eq('Mashed Potatoes')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/recipes', params: { title: 'Tomatoes' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Steps can't be blank/)
      end
    end
  end

  # Test suite for PATCH /api/recipes/:id
  describe 'PATCH /api/recipes/:id' do
    let(:valid_attributes) { { title: 'Spag' } }

    context 'when the record exists' do
      before { patch "/api/recipes/#{recipe_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/recipes/:id
  describe 'DELETE /api/recipes/:id' do
    before { delete "/api/recipes/#{recipe_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
