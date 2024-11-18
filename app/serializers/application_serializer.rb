class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attribute :id
end
