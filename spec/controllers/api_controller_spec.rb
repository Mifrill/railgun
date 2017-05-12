require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :controller, issues: [133] do
  controller do
    before_action :authenticate_usergjnccngfng
  end

  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }
  let(:authenticated_header) {
    { 'Authorization' => "Bearer #{create(:editor).api_token}" }
  }

  fdescribe 'GET /' do
    context 'authentication error' do
      it 'returns status code 401' do
        get :index
        expect(response).to have_http_status(401)
      end
    end

    context 'authentication ok' do
      before { get :index, params: { headers: authenticated_header } }
      it 'returns pages' do
        expect(response.parsed_body.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /:id' do
    before { get :show, id: page_id, headers: authenticated_header }

    context 'when the record exists' do
      it 'returns the page' do
        expect(response.parsed_body['id']).to eq(page_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      it 'returns status code 404' do
        get :show, id: -1, headers: authenticated_header
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /:id' do
    it 'returns status code 204' do
      delete :destroy, id: page_id, headers: authenticated_header

      expect(Page.find_by_id(page_id)).to be_nil
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404 if not found' do
      delete :destroy, id: -1, headers: authenticated_header

      expect(response).to have_http_status(404)
    end
  end
end
