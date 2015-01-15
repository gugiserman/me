# i18n Service
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
    $('[data-gg-i18n]').each -> $(this).text $(this).text().split('.').reduce index, data


# DOM Manipulation
class DOMDesigner
  constructor: ->
    ######


# Animations
class Animator
  constructor: ->
    @wow()
    @fadeOnScroll()

  wow: ->
    $('.wow').attr 'data-wow-delay', '.4s'
    $('.wow').attr 'data-wow-duration', '1s'
    $('.wow').attr 'data-wow-offset', '60'
    $('.wow.flipInX').attr 'data-wow-duration', '1.4s'
    new WOW().init()

  fadeOnScroll: ->
    opacities = []

    $('.gg-fade-on-scroll').each -> opacities.push $(this).css 'opacity'

    $(window).on 'scroll', ->
      $('.gg-fade-on-scroll').each (i) ->
        $this = $(this)
        v = (opacities[i] * 100) - (Math.floor ( ($(document).scrollTop() / $this.parent('.gg-section').height()) * 100 ) / 2)

        $this.css 'opacity', parseFloat v / 100


# App Model
class GisermanApp
  constructor: ->
    @isReady = false

    @designer = new DOMDesigner()
    @i18n = new i18nManager()
    @animator = new Animator()

    @isReady = true


$(document).ready -> window.giserman = new GisermanApp()
