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
    @bindAndListen()

  bindAndListen: ->
    viewportHeight = $(window).height()
    documentScrollTop = $(document).scrollTop()

    hasAnimated = ($elem) -> parseInt($elem.css 'opacity') > 0

    isVisible = ($elem) ->
      elementOffset = $elem.offset()
      elementHeight = $elem.height()

      minTop = documentScrollTop
      maxTop = documentScrollTop + viewportHeight

      (elementOffset.top > minTop && elementOffset.top + elementHeight < maxTop)

    whitelist = (e) -> isVisible($(e)) and !hasAnimated($(e))

    buildSequence = ->
      sequence = []

      slideDown = _.filter $('.gg-slide-down'), whitelist
      slideUp = _.filter $('.gg-slide-up'), whitelist
      bounce = _.filter $('.gg-bounce'), whitelist

      sequence.push elements: slideDown, properties: 'transition.slideDownIn', options: stagger: 200 if slideDown.length
      sequence.push elements: slideUp, properties: 'transition.slideUpIn', options: stagger: 200 if slideUp.length
      sequence.push elements: bounce, properties: 'transition.bounceIn', options: stagger: 200, sequenceQueue: false, delay: 200 if bounce.length

      return sequence

    $.Velocity.RunSequence buildSequence()
    $(window).on 'ggScrollEnd', -> $.Velocity.RunSequence buildSequence()


# App Model
class GisermanApp
  constructor: ->
    @isReady = false

    @designer = new DOMDesigner()
    @i18n = new i18nManager()
    @animator = new Animator()

    @isReady = true


$(document).ready -> window.giserman = new GisermanApp()
