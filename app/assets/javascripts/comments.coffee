# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  hideComments = (elem) ->
    $(elem).next().slideToggle()
    $(elem).next().find('.comment').slideUp()
    return

  $('#answers').on 'click', '.toggle-comments', ->
    hideComments this
    return

  $('#answers').on 'click', '.toggle-comment', ->
    hideComments this
    return
  return
