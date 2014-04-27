module GameHelper

  def possession_marker(game, type)
    content_tag :span, '', class: 'small glyphicon glyphicon-chevron-right' if game.possession? type
  end
end
