module Webmaster::PhotoBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps
    include UpdatedAgo

    # attibutes
    field :title, default: ''
    field :date, type: DateTime, default: -> { DateTime.now }

    # uploaders
    mount_uploader :image, Webmaster::PhotoImageUploader

    # scopes
    default_scope -> { desc(:date) }

    # pagination
    paginates_per 20

    def character_thumb_image
      image.small.url
    end
  end
end