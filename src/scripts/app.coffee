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
    $('.gg-i18n').each -> $(this).text $(this).text().split('.').reduce index, data


# DOM Manipulation
class DOMDesigner
  constructor: ->
    @middle()

  middle: ->
    $this = $(this)
    $('.middle').each -> $this.css 'top', ($this.parent('section').height() - $this.height()) / 2
      

# Animations
class Animator
  constructor: ->
    @attachSequences()
    @bindAndListen()

  attachSequences: ->

  bindAndListen: ->
    viewportHeight = $(window).height()
    documentScrollTop = $(document).scrollTop()

    hasAnimated = ($elem) -> $elem.data 'gg-animated'

    isVisible = ($elem) ->
      elementOffset = $elem.offset()
      elementHeight = $elem.height()

      minTop = documentScrollTop
      maxTop = documentScrollTop + viewportHeight

      (elementOffset.top > minTop && elementOffset.top + elementHeight < maxTop)


    fromHeaven = ($elem) -> $elem.velocity 'transition.slideDownIn', -> $elem.data 'gg-animated', true
    fromHell = ($elem) -> $elem.velocity 'transition.slideUpIn', -> $elem.data 'gg-animated', true

    $('.gg-fade-slide-down').each -> fromHeaven $(this) if isVisible $(this)
    $(window).on 'ggScrollEnd', ->
      $('.gg-fade-slide-down').each -> fromHeaven $(this) if !hasAnimated($(this)) and isVisible($(this))

    $('.gg-fade-slide-up').each -> fromHell $(this) if isVisible $(this)
    $(window).on 'ggScrollEnd', ->
      $('.gg-fade-slide-up').each -> fromHell $(this) if !hasAnimated($(this)) and isVisible($(this))


# App Model
class GisermanApp
  constructor: ->
    @isReady = false

    @designer = new DOMDesigner()
    @i18n = new i18nManager()
    @animator = new Animator()

    @isReady = true


$(document).ready -> window.giserman = new GisermanApp()
