{% extends "../layouts/default.html.swig" %}

{% block content %}
<div class="container">
	<div class="jumbotron text-center">
		<!--<img src="/images/logo.svg" width="160" class="pull-left" style="margin-right: 1.5em;">-->
		<h1>Über <span class="rmjs">RheinMainJS</span></h1>
	</div>
	<div class="row">
		<div class="col-sm-8 col-md-9 col-lg-8 lead">
			<p>
				<span class="rmjs">RheinMainJS</span> ist eine User Group zum Thema <strong>JavaScript</strong> und angrenzende Gebiete wie mobile Entwicklung.
				Wir treffen uns zurzeit etwa alle zwei Monate in Wiesbaden oder Mainz.
				Die Teilnahme steht jedem offen und ist kostenlos.
				Bei unseren Treffen werden in der Regel zwei Vorträge gehalten, anschließend gibt es noch Gelegenheit zum gegenseitigen Austausch.</p>

			<p><span class="rmjs">RheinMainJS</span> wird organisiert von</p>
			<ul class="list-unstyled">
			{% for user in data.organizers %}
			<li>
				<img src="{{ user._.email.gravatarUrl() }}" style="margin-top:10px" class="img-circle img-gravatar"/>
				<a href="{{ user.website }}">{{ user.name.full }}</a>
			</li>
			{% endfor %}
			</ul>

			<p><span class="rmjs">RheinMainJS</span> und <a href="http://frankfurtjs.org/">FrankfurtJS</a> finden zeitlich abgestimmt im Wechsel statt - schau doch auch dort einmal vorbei!</p>

			<p>Danke an <a href="http://www.sebastianfastner.de/">Sebastian Fastner</a> für die Domain und den <a href="https://twitter.com/RheinMainJS">Twitter-Account</a>.</p>

			<h3>Eigene Vorträge</h3>

			<p>Wer etwas zu einem interessanten Thema erzählen möchte, darf und soll gern einen Vortrag halten. Melde dich bei Interesse einfach bei uns: <a href="mailto:orga@rheinmainjs.de">orga@rheinmainjs.de!</a></p>
		</div>
		<!--<div class="col-lg-4">-->
			<!--{% include "../includes/twitter.html.swig" %}-->
		<!--</div>-->
	</div>
</div>
{% endblock %}
