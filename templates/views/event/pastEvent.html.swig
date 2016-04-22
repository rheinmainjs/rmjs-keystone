{% macro pastEvent(event, talks) %}
<div class="event" data-ks-editable="editable(user, { list: " Event ", id: event.id })" itemscope itemtype="http://schema.org/Event">
<h3 itemprop="name" class="event-title">
	{{ event.title }}
	{# am {{event._.eventDateTime.moment().locale('de').format('DD.MM.YYYY') }} #}
</h3>
{% if event.description.extended %}
<blockquote class="event-description-extended" itemprop="description">{{ event.description.extended|safe }}</blockquote>
{% endif %}
<dl class="dl-horizontal">
	<dt>Talks <i class="fa fa-comments-o" style="width: 1.5em;"></i></dt>
	<dd>
		<ul class="list-unstyled">
			{% for talk in talks %}
			{% if talk.event == event.id %}
			<li><span class="talk-title">&ldquo;{{ talk.name }}&rdquo;</span> von
				{% for speaker in talk.who %}
					<a href="{{ speaker.website }}">{{ speaker.name.first }} {{ speaker.name.last }}</a>
				{% endfor %}
                {% if talk.slides %} (<a href="{{ talk.slides }}"><i class="fa fa-external-link" style="width: 1.2em;"></i>Slides</a>) {% endif %}
			</li>
			{% endif %}
			{% endfor %}
		</ul>
	</dd>

	<dt>Wann <i class="fa fa-clock-o" style="width: 1.5em;"></i></dt>
	<dd>
		<meta itemprop="startDate" content="{{ event._.eventDateTime.moment().locale('de').format() }}"
		      data-ics-start="{{ event._.eventDateTime.moment().locale('en').format('MM/DD/YYYY HH:mm') }}"
		      data-ics-end="{{ event._.eventDateTime.moment().add(3, 'h').locale('en').format('MM/DD/YYYY HH:mm') }}">
		<time datetime="{{ event._.eventDateTime.moment().locale('de').format() }}">{{
			event._.eventDateTime.moment().locale('de').format('dddd, Do MMMM YYYY') }}, ab {{
			event._.eventDateTime.moment().locale('de').format('HH:mm') }} Uhr
		</time>
	</dd>

	<dt>Wo <i class="fa fa-map-marker" style="width: 1.5em;"></i></dt>
	<dd>
		<address itemprop="location" itemscope itemtype="http://schema.org/Place">
			<a itemprop="url" itemprop="name" href="{{ event.location.website }}">{{ event.location.title }}</a><br/>
			<div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
				<span itemprop="streetAddress">{{ event.location.streetaddress }}</span><br/>
				<span itemprop="postalCode">{{ event.location.zip }}</span> <span itemprop="addressLocality">{{ event.location.city }}</span>
			</div>
			{% if event.location.twitter %}<i class="fa fa-twitter"></i> <a href="https://twitter.com/{{ event.location.twitter }}">@{{ event.location.twitter }}</a>{% endif %}<br/>
		</address>
	</dd>
</dl>
</div>
{% endmacro %}
