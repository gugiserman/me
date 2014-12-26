# i18n
class i18nManager
  constructor: ->
    @supportedLanguages = ['pt-BR', 'en-US']
    @language = @getLang()
    @data = {}

    @setData().done => @translate()

  getLang: =>
    lang = navigator?.userLanguage or navigator?.language or 'pt-BR'
    if lang in @supportedLanguages then lang else 'pt-BR'

  setData: => $.getJSON("/i18n/#{@language}.json", cache: true).done (data) => @data = data

  translate: =>
    data = @data
    index = (obj, i) -> obj[i]
    $('.gg-i18n').each -> $(this).text $(this).text().split('.').reduce index, data


# DOM
class DOMDesigner
  constructor: ->
    @middle()

  middle: ->
    $this = $(this)
    $('.middle').each -> $this.css 'top', ($this.parent('section').height() - $this.height()) / 2


# App
class GisermanApp
  constructor: ->
    @designer = new DOMDesigner()
    @i18n = new i18nManager()


$(document).ready -> window.giserman = new GisermanApp()
