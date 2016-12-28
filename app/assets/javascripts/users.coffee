# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

  $('#search').autocomplete(
    source: '/search_suggestions'
    select: (event, ui) ->
      location.href = '/users/' + ui.item.id
      return
  ).data('ui-autocomplete')._renderItem = (ul, item) ->
    $('<li>').data('ui-autocomplete-item', item).append('<a>' + '<span class="img">' + '<img src="' + item.image_url + '" />' + '</span>' + '<span class="title">' + item.name + '</span>' + '<span class="author">' + item.trips + " Trips" + '</span>' + '<span class="price">' + 'User since: ' + item.user_since + '</span>' + '</a>').appendTo ul


