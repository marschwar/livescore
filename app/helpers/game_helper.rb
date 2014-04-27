module GameHelper

  def possession_marker(game, type)
    if game.possession? type
      content_tag :span, '',
        class: 'small glyphicon glyphicon-chevron-right',
        title: Game.human_attribute_name(:possession)
    end
  end
end
