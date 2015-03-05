{% extends "../layouts/default.html.swig" %}

{% block content %}
<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-8">
			<article>
				{% if not data.event %}
					<h2>Ungültiges Event.</h2>
				{% else %}
					<header>
						<p>{{ data.event._.eventDateTime.moment().locale('de').format('dddd, Do MMMM YYYY') }}</p>
						<h1>{{ data.event.title }}</h1>
					</header>
					<div class="post">
						{% if data.event.description.extended %}
							<p>{{ data.event.description.extended }}</p>
						{% endif %}
						{% if data.event.location.title %}
							<p>Das Event fand bei <a href="{{ data.event.location.website }}">{{ data.event.location.title }}</a> statt.</p>
						{% endif %}
					</div>
					<h2>Talks</h2>
					<ul>
						{% for talk in data.talks %}
						<li>
							<strong>{{ talk.name }}</strong>
							von
							<ul>
							{% for user in talk.who %}
								{% if user.homepage %}
									{% set userlink = user.homepage %}
								{% elseif user.website %}
									{% set userlink = user.website %}
								{% elseif user.twitter %}
									{% set userlink = 'https://twitter.com/' %}
									{% set userlink = user.twitter %}
								{% endif %}
								<li><a href="{{ userlink }}">{{ user.name.full }}</a></li>
							{% endfor %}
							</ul>
						</li>
						{% endfor %}
					</ul>
				{% endif %}
			</article>
			<div id="map"></div>

			<script type="text/javascript">
			var coords = [
				parseFloat("{{ data.event.location.geo.latitude }}"),
				parseFloat("{{ data.event.location.geo.longitude }}")
			],
			locationName = "{{data.event.location.title}}";
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
		</div>
		<div class="col-sm-4 col-md-4">
			{% include "../includes/twitter.html.swig" %}
		</div>
	</div>
</div>
{% endblock %}
