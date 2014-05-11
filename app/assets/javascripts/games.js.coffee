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
        url = $(this).data('url')
        $this.typeahead {
          items: 4,
          minLength: 3,
          source: (query, process) ->
            $.get url + "?q=" + query, (data) ->
              process data
            , 'json'
        }

) jQuery

