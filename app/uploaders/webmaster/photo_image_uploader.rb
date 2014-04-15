class Webmaster::PhotoImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ActionView::Helpers::AssetUrlHelper

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("assets/fallback/" + [version_name, "webmaster_photo_image.png"].compact.join('_'))
  end

  version :small do
    process :resize_to_fill => [50, 50]
  end

  version :grid do
    process :resize_to_fit => [254, nil]
  end

  version :large do
    process :resize_to_fit => [660, nil]
  end
end