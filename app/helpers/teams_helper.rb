module TeamsHelper

  def team_image(team, size = 50)
    if team.encoded_image.present?
      image_tag "#{team_path(team)}.#{team.image_type}", alt: "#{team.name} Logo", title: "#{team.name} Logo", style: "max-width: #{size}px;max-height: #{size}px" 
      # raw(%Q(<img src="#{team.encoded_image}" alt="#{team.name} Logo" title="#{team.name} Logo" style="max-width: #{size}px;max-height: #{size}px" />))
    end
  end
end
