require 'rails_helper'

RSpec.describe CollectionsController, vcr: true do

  describe "GET index" do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @collections' do
      assigns(:collections).each do |collection|
        expect(collection).to be_a(Grom::Node)
        expect(collection.type).to eq('https://id.parliament.uk/schema/Collection')
      end
    end

    it 'assigns @collections in alphabetical order' do
      expect(assigns(:collections)[0].name).to eq('collectionName 1')
      expect(assigns(:collections)[1].name).to eq('collectionName 2')
    end

    it 'rejects nodes with parents when assigning @collections' do
      expect(assigns[:collections].map(&:name)).to_not include('collectionWithParents')
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/collection_index"
          }
        ]

      before(:each) do
        headers = { 'Accept' => 'application/rdf+xml' }
        request.headers.merge(headers)
      end

      it 'should have a response with http status redirect (302)' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to have_http_status(302)
        end
      end

      it 'redirects to the data service' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to redirect_to(method[:data_url])
        end
      end

    end
  end
end
