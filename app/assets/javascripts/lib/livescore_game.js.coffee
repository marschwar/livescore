class window.LivescoreGame
  constructor: (@element, options = {}) ->
    @interval = options.interval || 60
    @max_interval = options.max_interval || 600
    @setupPolling()

  setupPolling: (interval = @interval) ->
    self = @
    @current_interval = interval + Math.round(20 * Math.random()) 
    self.poller = setInterval( ->
      $.ajax self.getUrl(),
        type: 'GET'
        dataType: 'json'
        success: (data, textStatus, jqXHR) ->
          self.update_ui data
          self.resetTimer data
    , @current_interval * 1000)

  getUrl: ->
    @element.data('url')

  update_ui: (data) ->
    @update_started_marker data
    @update_fields data
    @update_possession_marker data

  resetTimer: (data) ->
    clearInterval(@poller)
    if data.started
      @setupPolling(@interval)
    else if !data.final
      @setupPolling(Math.min(@max_interval, @current_interval * 2))


  update_started_marker: (data) ->
    if data.started
      @element.addClass('started')
    else
      @element.removeClass('started')

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
