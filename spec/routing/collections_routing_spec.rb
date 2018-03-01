require 'rails_helper'

RSpec.describe 'collections', type: :routing do
  describe 'CollectionsController' do
    include_examples 'index route', 'collections'
  end
end
