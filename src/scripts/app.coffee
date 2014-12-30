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
    @panning()

  middle: ->
    mid = ->
      $('.middle').each ->
        $this = $(this)
        margin = Math.ceil (($(window).height() - $this.height()) / 2)

        $this.css 'margin-top', margin
        $this.css 'margin-bottom', margin

    mid()
    $(window).on 'resize', mid

  panning: ->
    $elems = $('.gg-panning')
    mouse = x: 0, y: 0
    originalPosition = []

    $elems.each (i) ->
      originalValue = $(this).css('background-position').split ' '
      originalPosition[i] =
        x: parseInt originalValue[0].replace '%', ''
        y: parseInt originalValue[1].replace '%', ''

    calculateNewPosition = (current, direction, diff) ->
      diffPercentage =
        x: Math.floor ( (diff.x / $(window).height()) * 100 ) / 2
        y: Math.floor ( (diff.y / $(window).height()) * 100 ) / 2

      newPosition =
        x: if direction.x is 'left' then current.x += diffPercentage.x else current.x -= diffPercentage.x
        y: if direction.y is 'up' then current.y -= diffPercentage.y else current.y += diffPercentage.y

      if newPosition.x > 100 then newPosition.x = 100
      if newPosition.y > 100 then newPosition.y = 100

      if newPosition.x < 0 then newPosition.x = 0
      if newPosition.y < 0 then newPosition.y = 0

      return newPosition

    handlePanning = (e) ->
      x = e.clientX or e.pageX
      y = e.clientY or e.pageY

      direction =
        x: if mouse.x > x then 'left' else 'right'
        y: if mouse.y > y then 'up' else 'down'

      diff =
        x: Math.abs x - mouse.x
        y: Math.abs y - mouse.y

      mouse = _.extend mouse, x: x, y: y

      $elems.each (i) ->
        current = $(this).css('background-position').split ' '

        position =
          x: parseInt current[0].replace '%', ''
          y: parseInt current[1].replace '%', ''

        newPosition = calculateNewPosition position, direction, diff

        excludes =
          x: $(this).hasClass 'gg-panning-exclude-x'
          y: $(this).hasClass 'gg-panning-exclude-y'

        newValue =
          x: "#{ if excludes.x then originalPosition[i].x else newPosition.x }%"
          y: "#{ if excludes.y then originalPosition[i].y else newPosition.y }%"

        $(this).css 'background-position', "#{ newValue.x }% #{ newValue.y }%"

    $(document).on 'mousemove', handlePanning


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
