class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url  
    ActionController::Base.helpers.asset_path(
      "fallbacks/#{model.class.to_s.underscore}/#{mounted_as}/" +
      (version_name || :default).to_s + ".jpg")
  end
end
