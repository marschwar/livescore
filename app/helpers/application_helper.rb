module ApplicationHelper

  # when using carrierwave you ca pass the version as option
  def entity_image(entity, options = { })
    options = { title: h(entity.name), alt: h(entity.name) }.merge(options)
    has_carrierwave_image?(entity) ? carrierwave_image(entity, options) : image_from_database(entity, options)
  end

private
  def image_from_database(entity, options)
    if entity.encoded_image.present?
      options = { size: 50 }.merge(options)
      options[:style] = "#{options[:style]};max-width: #{options[:size]}px;max-height: #{options[:size]}px"
      image_tag "#{polymorphic_path(entity)}.#{entity.image_type}", options
    end
  end

  def has_carrierwave_image?(entity)
    entity.respond_to?(:uploader) && entity.uploader.url.present?
  end

  def carrierwave_image(entity, options)
    if entity.uploader.url.present?
      if options[:version]
        image_tag entity.uploader.send(options.delete(:version)).url, options
      else
        image_tag entity.uploader.url, options
      end
    end
  end
end
