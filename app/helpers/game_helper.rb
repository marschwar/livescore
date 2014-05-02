module GameHelper

  def possession_marker(game, type)
    hidden_class = "hidden" unless game.possession? type
    content_tag :span, '',
      class: "possession-marker #{hidden_class} small glyphicon glyphicon-chevron-right",
      title: Game.human_attribute_name(:possession),
      data: { livescore_possession: type }
  end
end
