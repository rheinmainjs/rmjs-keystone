{% extends "../layouts/default.html.swig" %}

{% import "event/eventCalendar.html.swig" as eventCalendar %}
{% import "event/eventMap.html.swig" as eventMap %}
{% import "index/latestEvent.html.swig" as latestEvent %}

{% block content %}
<div class="container">
	<div class="jumbotron text-center">
		<!--<img src="/images/logo.svg" width="160" class="pull-left" style="margin-right: 1.5em;">-->
		<h1>Willkommen bei <span class="rmjs">RheinMainJS</span></h1>
		<h2>JavaScript User Group Wiesbaden und Mainz</h2>
	</div>
	<div class="row">
		{% if data.event %}
		<div class="hidden-sm col-md-2 col-lg-2">
			{# @todo calendar und event in 1 file #}
			{{ eventCalendar.eventCalendar(data.event) }}
		</div>
		<div class="col-sm-9 col-md-9 col-lg-9">
			<div>{{ latestEvent.latestEvent(data.event, data.talks) }}</div>
			{{ eventMap.eventMap(data.event) }}
		</div>
		{% else %}
		<div class="col-lg-12 lead text-center text">
			<p>Aktuell gibt es noch keinen festen Termin für das nächste Meetup, aber wir arbeiten hinter den Kulissen eifrig an der nächsten Veranstaltung. Wenn du ein interessantes Thema hast oder einen Talk halten willst, dann melde dich bei uns.</p>
		</div>
		<div class="col-lg-12 lead text-center text">
			<p>Wenn du immer auf dem neuesten Stand bleiben möchtest, folge uns auf Twitter, Google Plus, abonniere den <a href="/rss" class="fa fa-rss">&nbsp;RSS-Feed</a>, oder schaue einfach regelmäßig hier vorbei. Wir sehen uns auf dem nächsten Meetup!</a></p>
		</div>
		<div class="col-lg-12">
			<img src="images/group.jpg" class="img-responsive" alt="Bei einem User Group Meetup"/>
		</div>
		{% endif %}
	</div>
</div>
{% endblock %}

{% block js %}
<script type="text/javascript">
	$(document).ready(function () {
		var cal_single = ics();
		var eventTitle = $('[itemprop="name"]').text(),
				eventSummary = $('[itemprop="description"]').text().replace(/\r?\n|\r/g, ', '),
				eventLocation = [$('[itemprop="location"] a').text(), $('[itemprop="streetAddress"]').text(), $('[itemprop="addressLocality"]').text()].join(', '),
				eventStartdate = $('[itemprop="startDate"]').data('ics-start'),
				eventEnddate = $('[itemprop="startDate"]').data('ics-end');
		cal_single.addEvent(eventTitle, eventSummary, eventLocation, eventStartdate, eventEnddate);
		jQuery(".ical-download").on('click', function (event) {
			cal_single.download('rmjs');
			event.preventDefault();
		});
	});
</script>
{% endblock %}
