require 'open-uri'

module HasImage
  extend ActiveSupport::Concern

  def has_image?
    encoded_image.present?
  end

  def image_mime_type
    "image/#{image_type}" if image_type
  end

  def raw_image_data
    if has_image?
      Base64.strict_decode64 encoded_image
    end
  end

  def image_url=(url)
    uri = URI.parse(url)
    # TODO: use monkey patch or gem instead to allow redirects from http to https
    uri.scheme = 'https' 
    img = uri.read
    if /^image\/(?<type>\S+)/ =~ img.content_type
      self.encoded_image = Base64.strict_encode64(img)
      self.image_type = type
    end
  end
end