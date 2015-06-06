@app ?= {}

(($) ->

  $(document).ready ->
    app.games.init()

  app.games =
    init: ->
      @init_typeahead()

    init_typeahead: ->
      $('input.js-typeahead').each ->
        $this = $(this)
        url = $this.data('url')
        minLength = $this.data('minlength') || 3
        $this.typeahead {
          items: 12,
          minLength: minLength,
          source: (query, process) ->
            $.get url + "?q=" + query, (data) ->
              process data
            , 'json'
        }

) jQuery

