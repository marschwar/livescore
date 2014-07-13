module EntityImage
  extend ActiveSupport::Concern

  def send_image(image, type)
    response.headers["Cache-Control"] = 'public,max-age=600,s-maxage=1200'
    send_data image, type: type, disposition: :inline
  end
end