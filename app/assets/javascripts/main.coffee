# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_datepicker = ->
  $('.datepicker').datepicker format: "dd/mm/yyyy",  autoclose: true

$(document).ready ->
	set_datepicker()

$(document).on 'turbolinks:load', ->
	set_datepicker()
