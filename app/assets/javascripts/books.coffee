# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  navItems = $('.admin-menu li > a')
  navListItems = $('.admin-menu li')
  allWells = $('.admin-content')
  allWellsExceptFirst = $('.admin-content:not(:first)')
  allWellsExceptFirst.hide()
  navItems.click (e) ->
    e.preventDefault()
    navListItems.removeClass 'active'
    $(this).closest('li').addClass 'active'
    allWells.hide()
    target = $(this).attr('data-target-id')
    $('#' + target).show()
    return
  return
  