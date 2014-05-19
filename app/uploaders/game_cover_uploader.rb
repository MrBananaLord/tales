class GameCoverUploader < BaseUploader

  version :thumb do
    process resize_to_fill: [80, 80]
  end
  
  version :default do
    process resize_to_fill: [1140, 400]
  end

end
