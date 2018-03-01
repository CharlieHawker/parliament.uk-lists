require 'rails_helper'

RSpec.describe 'collections/index', vcr: true do
  before do
    assign(:collections, [double(:collection, name: 'Guide to Procedure', description: 'Practical, clearly written guidance on House of Commons procedure for MPs and their staff', graph_id: 'KL2k1BGP')])
    render
  end

  context 'header' do
    it 'will render the page title' do
      expect(rendered).to match(/Collections/)
    end
  end

  context 'links' do
    it 'will render collection_path' do
      expect(rendered).to have_link('Guide to Procedure', href: collection_path('KL2k1BGP'))
    end
  end
end
