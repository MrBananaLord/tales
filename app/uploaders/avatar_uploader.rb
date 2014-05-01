class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url  
    ActionController::Base.helpers.asset_path("fallback/avatar/" + [version_name, "default.png"].compact.join('_'))
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fill: [80, 80]
  end
  
  version :default do
    process resize_to_fill: [200, 200]
  end

end
