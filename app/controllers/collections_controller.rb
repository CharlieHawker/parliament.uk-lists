class CollectionsController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index: proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.collection_index }
  }.freeze

  def index
    @collections = @request.get.sort_by(:name).reject { |c| c.parents.any? }
  end
end
