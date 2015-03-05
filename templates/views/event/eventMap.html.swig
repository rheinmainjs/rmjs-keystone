{% macro eventMap(event) %}
<div id="map" class="shadow-box"></div>
<script type="text/javascript">
	var coords = [
				parseFloat("{{ event.location.geo.latitude }}"),
				parseFloat("{{ event.location.geo.longitude }}")
			],
			locationName = "{{ event.location.title }}";
	var map = L.map('map', {
		center: coords,
		zoom: 15
	});
	L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png", {
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(map);
	var marker = L.marker(coords).addTo(map);
	marker.bindPopup(locationName);
</script>
{% endmacro %}
