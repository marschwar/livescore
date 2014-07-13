module ApplicationHelper
  def entity_image(entity, options = { size: 50 })
    if entity.encoded_image.present?
      options[:style] = "max-width: #{options[:size]}px;max-height: #{options[:size]}px" 
      image_tag "#{polymorphic_path(entity)}.#{entity.image_type}", options 
    end
  end
end
