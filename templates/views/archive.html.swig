{% extends "../layouts/default.html.swig" %}

{% import "event/eventCalendar.html.swig" as cal %}
{% import "event/pastEvent.html.swig" as pe %}

{% block content %}
<div class="container">
	<div class="jumbotron text-center">
		{% if data.category %}
			<h1>{{ data.category.name }}</h1>
		{% else %}
			<h1>Veranstaltungs-Archiv</h1>
		{% endif %}
	</div>
	<div class="row">
		{% if data.events.results.length %}
		<div class="col-lg-12">
			{% if data.events.totalPages > 1 %}
			<h4 class="text-weight-normal">
				Zeige
				<strong>{{ data.events.first }}</strong>
				bis
				<strong>{{ data.events.last }}</strong>
				von
				<strong>{{ data.events.total }}</strong>
				Events.
			</h4>
			{% endif %}
		</div>
		<div class="col-lg-12">
			<div class="archive row">
				{% for event in data.events.results %}
				<div class="hidden-sm col-md-2 col-lg-2">
					{{ cal.eventCalendar(event) }}
				</div>
				<div class="col-sm-9 col-md-9 col-lg-9">
					<div>{{ pe.pastEvent(event, data.talks) }}</div>
				</div>
				{% endfor %}
			</div>
			{% if data.events.totalPages > 1 %}
				<ul class="col-md-offset-1 pagination">

					{% if data.events.previous %}
						<li>
							<a href="?page={{ data.events.previous }}">
								<span class="glyphicon glyphicon-chevron-left"></span>
							</a>
						</li>
					{% else %}
						<li class="disabled">
							<a href="?page=1">
								<span class="glyphicon glyphicon-chevron-left"></span>
							</a>
						</li>
					{% endif %}

					{% for p in data.events.pages %}
						{% set classAttr = "" %}
						{% if data.events.currentPage == p %}
							{% set classAttr = "active" %}
						{% endif %}
						<li class="{{ classAttr }}">
							{% if p == "..." %}
								{% if i %}
									{% set page = data.posts.totalPages %}
								{% else %}
									{% set page = 1 %}
								{% endif %}
							{% else %}
								{% set page = p %}
							{% endif %}
							<a href="?page={{ page }}">{{ p }}</a>
						</li>
					{% endfor %}

					{% if data.events.next %}
						<li>
							<a href="?page={{ data.events.next }}">
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</li>
					{% else %}
						<li class="disabled">
							<a href="?page={{ data.events.totalPages }}">
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</li>
					{% endif %}

				</ul>
			{% endif %}
		</div> {#col-lg-12#}
		{% else %}
			<h3 class="text-muted">Es gibt noch keine Veranstaltungen.</h3>
		{% endif %}
	</div> {#row#}
</div> {#container#}
{% endblock %}
