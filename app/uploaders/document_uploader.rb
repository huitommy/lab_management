class DocumentUploader < CarrierWave::Uploader::Base

  if Rails.env == "test"
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf doc htm html docx pages)
  end

end
