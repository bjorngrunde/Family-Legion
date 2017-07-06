window.Utils = ->

window.Utils.prototype =
  constructor: Utils
  isElementInView: (element, fullyInView) ->
    pageTop = $(window).scrollTop()
    pageBottom = pageTop + $(window).height()
    elementTop = $(element).offset().top
    elementBottom = elementTop + $(element).height()
    if fullyInView == true
      pageTop < elementTop and pageBottom > elementBottom
    else
      elementTop <= pageBottom and elementBottom >= pageTop
window.Utils = new Utils
