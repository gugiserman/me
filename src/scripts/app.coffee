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

  setData: => $.getJSON("/i18n/#{@language}.json").done (data) => @data = data

  translate: =>
    data = @data
    index = (obj, i) -> obj[i]
    $('.gg-i18n').each -> $(this).text $(this).text().split('.').reduce index, data


# App
class GisermanApp
  constructor: ->
    @i18n = new i18nManager()


$(document).ready -> window.giserman = new GisermanApp()
