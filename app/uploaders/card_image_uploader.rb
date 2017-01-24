class CardImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  process resize_to_fit: [360, 360]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
