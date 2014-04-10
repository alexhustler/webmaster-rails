module Webmaster::PhotoBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps
    include UpdatedAgo

    # attibutes
    field :title
    field :description
    field :date, type: Date, default: -> { Date.today }

    # uploaders
    mount_uploader :image, Webmaster::PhotoImageUploader

    def character_thumb_image
      image.small.url
    end
  end
end