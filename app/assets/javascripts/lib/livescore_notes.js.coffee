class window.LivescoreNotes
  constructor: (@element, options = {}) ->
    @interval = options.interval || 60
    @setupPolling()

  setupPolling: ->
    self = @
    setInterval( ->
      self.element.load self.getUrl()
    , @interval * 1000)

  getUrl: ->
    @element.data('url')