{% macro eventCalendar(event) %}
<div class="meetup-calendar calendar hidden-xs hidden-sm">
	<div class="calendar-header">{{ event._.eventDateTime.moment().locale('de').format('MMMM') }}</div>
	<div class="calendar-body">
		<div class="calendar-date">{{ event._.eventDateTime.moment().locale('de').format('DD') }}</div>
		<div class="calendar-year">{{ event._.eventDateTime.moment().locale('de').format('YYYY') }}</div>
	</div>
</div>
{% endmacro %}
