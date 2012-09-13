# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path "/assets/fallback/#{model.class.name.underscore}/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [1170, 2000]
  process :convert => 'png'

  version :full do
    process :resize_to_fit => [770, 2000]
    process :convert => 'png'
  end

  version :medium do
    process :resize_to_fill => [370, 370]
    process :convert => 'png'
  end

  version :small do
    process :resize_to_fill => [170, 170]
    process :convert => 'png'
  end

  version :thumb do
    process :resize_to_fill => [70, 70]
    process :convert => 'png'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= "#{md5}.png" if original_filename.present?
  end

  protected
  def md5
    @md5 ||= Digest::MD5.hexdigest(model.image.read)
  end

end