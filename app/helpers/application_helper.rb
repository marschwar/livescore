module ApplicationHelper
  def entity_image(entity, options = { })
    if entity.encoded_image.present?
      options = { size: 50, title: entity.name, alt: entity.name }.merge(options)
      options[:style] = "#{options[:style]};max-width: #{options[:size]}px;max-height: #{options[:size]}px" 
      image_tag "#{polymorphic_path(entity)}.#{entity.image_type}", options 
    end
  end
end
