$('#venues_list').html("<%= j render('list', {venues: @venues, term: @term}) %>").fadeIn()
<% unless @coordinates.blank? %>
venues_map(new google.maps.LatLng(<%= @coordinates.first %>, <%= @coordinates.last %>))
<% end %>