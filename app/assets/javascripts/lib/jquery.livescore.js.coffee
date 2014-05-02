$ = jQuery

$.fn.extend
  livescore: (options) ->
    # Default settings
    settings =
      interval: 60
      type: 'game'
    settings = $.extend settings, options

    init = (element) ->
      if (settings.type == 'notes')
        return new LivescoreNotes(element, settings)
      else if (settings.type == 'game')
        return new LivescoreGame(element, settings)

    return @each () ->
      self = $(this)
      unless self.data('__livescore')
        updater = init(self)
        self.data('__livescore', updater)
