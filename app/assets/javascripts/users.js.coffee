$ ->
  $('#user_date_of_birth').datepicker('setStartDate', '<%= I18n.l 90.years.ago.to_date %>');
  $('#user_date_of_birth').datepicker('setEndDate', '<%= I18n.l 13.years.ago.to_date %>');