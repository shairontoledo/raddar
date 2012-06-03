$('#venues_list').html("<%= j render('list', {venues: @venues, term: @term}) %>").fadeIn()
<% unless @venues.empty? %>
venues_map(new google.maps.LatLng(<%= @coordinates.first %>, <%= @coordinates.last %>))
<% end %>