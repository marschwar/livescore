$ = jQuery

class window.QuickUpdate
  constructor: (@element, options = {}) ->
    @init()

  init: ->
    self = @
    @element.find('.js-quick-edit-value').click ->
      $this = $(this)
      self.send($this.data())


  send: (data) ->
    $.ajax @getUrl(),
      type: 'POST'
      dataType: 'json'
      data: data
      success: (data, textStatus, jqXHR) ->
        alert data['message']
      error: (data, textStatus, jqXHR) ->
        alert data.responseJSON.message

  getUrl: ->
    @element.data('url')

$.fn.extend
  quickupdate: (options) ->
    # Default settings
    settings = {}
    settings = $.extend settings, options

    init = (element) ->
      return new QuickUpdate(element, settings)

    return @each () ->
      self = $(this)
      unless self.data('quickupdate')
        updater = init(self)
        self.data('quickupdate', updater)
