Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.KioskView extends Backbone.View
  el: '#kiosk-mode'
  active: false

  initialize: =>
    @$el.click(@kioskToggle)

  kioskToggle: (e) =>
    e.preventDefault()
    if @active
      @$el.find('img#active').fadeOut 'fast', =>
        @$el.find('img#inactive').fadeIn 'fast'
      $('.app h2').removeClass('kiosk')
      @active = false
    else
      @$el.find('img#inactive').fadeOut 'fast', =>
        @$el.find('img#active').fadeIn 'fast'
      $('.app h2').addClass('kiosk')
      @active = true
    @trigger('kioskToggle')
