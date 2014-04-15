module Webmaster::PhotoBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps
    include UpdatedAgo

    # attibutes
    field :title, default: ''
    field :description, default: ''
    field :date, type: Date, default: -> { Date.today }

    # uploaders
    mount_uploader :image, Webmaster::PhotoImageUploader

    # scopes
    default_scope -> { desc(:date) }

    def character_thumb_image
      image.small.url
    end
  end
end