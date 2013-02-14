Runciter.Views.Apps ||= {}

class Runciter.Views.Apps.KioskView extends Backbone.View
  el: '#kiosk-mode'
  active: false

  initialize: =>
    @$el.click(@kioskToggle)

  kioskToggle: =>
    if @$el.hasClass('active')
      @$el.removeClass('active')
      @active = false
    else
      @$el.addClass('active')
      @active = true
    @trigger('kioskToggle', @active)