class window.LivescoreGame
  constructor: (@element, options = {}) ->
    @interval = options.interval || 60
    @setupPolling()

  setupPolling: ->
    self = @
    self.poller = setInterval( ->
      $.ajax self.getUrl(),
        type: 'GET'
        dataType: 'json'
        success: (data, textStatus, jqXHR) ->
          self.update_ui data
          self.cancelTimer data
    , @interval * 1000)

  getUrl: ->
    @element.data('url')

  update_ui: (data) ->
    @update_fields data
    @update_possession_marker data

  cancelTimer: (data) ->
    if data.final
      clearInterval(@poller)

  update_fields: (data) ->
    @element.find("*[data-livescore-path]").each ->
      $field = $(this)
      new_value = eval('data.' + $field.data('livescore-path'))
      $field.html(new_value)

  update_possession_marker: (data) ->
    @element.find("*[data-livescore-possession]").each ->
      $marker = $(this)
      if data.possession == $marker.data('livescore-possession')
        $marker.removeClass('hidden')
      else
        $marker.addClass('hidden')
