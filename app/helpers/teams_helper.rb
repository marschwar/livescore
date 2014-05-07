module TeamsHelper

  def team_image(team, size = 50)
    raw(%Q(<img src="#{team.encoded_image}" alt="#{team.name} Logo" title="#{team.name} Logo" style="max-width: #{size}px;max-height: #{size}px" />)) if team.encoded_image.present?
  end
end
