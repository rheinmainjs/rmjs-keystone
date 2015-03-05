{% extends "../layouts/default.html.swig" %}

{% macro blogPost(post) %}
<div class="post" data-ks-editable="editable(user, { list: " Post ", id: post.id })">
	<h2>
		<a href="/news/post/{{ post.slug }}">{{ post.title }}</a>
	</h2>
	<h6>Geschrieben
		{% if post.publishedDate %}
			am {{ post._.publishedDate.format("DD.MM.YYYY") }}
		{% endif %}
		{% if post.categories and post.categories.length %}
			in {% for cat in post.categories %}<a href="/news/{{ cat.key }}">{{ cat.name }}</a>{% if loop.index < post.categories.length %}, {% endif %}{% endfor %}
		{% endif %}
		{% if post.author %}
			von {{ post.author.name.first }}
		{% endif %}
	</h6>
	{% if post.image.exists %}
		<img src="{{ post._.image.fit(160,160) }}" class="img pull-right">
	{% endif %}
	<p>{{ post.content.brief|safe }}</p>
	{% if post.content.extended %}
		<p class="read-more">
			<a href="/news/post/{{ post.slug }}">Weiterlesen…</a>
		</p>
	{% endif %}
</div>
{% endmacro %}

{% block intro %}
<div class="container">
	<div class="jumbotron text-center">
		{% if data.category %}
		<h1>{{ data.category.name }}</h1>
		{% else %}
		<h1><span class="rmjs">RheinMainJS</span> News</h1>
		{% endif %}
	</div>
</div>
{% endblock %}

{% block content %}
<div class="container">
	<div class="row">
			{% if filters.category and not data.category %}
				<h3 class="text-muted">Ungültige Kategorie.</h3>
			{% else %}
				<div class="col-lg-12">
				{% if data.posts.results.length %}
					<a href="/rss" class="fa fa-rss btn btn-default pull-right" role="button" title="RSS"></a>
					{% if data.posts.totalPages > 1 %}
						<h4 class="text-weight-normal">
							Zeige
							<strong>{{ data.posts.first }}</strong>
							bis
							<strong>{{ data.posts.last }}</strong>
							von
							<strong>{{ data.posts.total }}</strong>
							News.
						</h4>
					{% endif %}
				</div>
				<div class="col-sm-8 col-md-9 col-lg-8">
					<div class="blog">
						{% for post in data.posts.results %} {{ blogPost(post) }} {% endfor %}
					</div>
					{% if data.posts.totalPages > 1 %}
						<ul class="pagination">

							{% if data.posts.previous %}
								<li>
									<a href="?page={{ data.posts.previous }}">
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

							{% for p in data.posts.pages %}
								{% set classAttr = "" %}
								{% if data.posts.currentPage == p %}
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

							{% if data.posts.next %}
								<li>
									<a href="?page={{ data.posts.next }}">
										<span class="glyphicon glyphicon-chevron-right"></span>
									</a>
								</li>
							{% else %}
								<li class="disabled">
									<a href="?page={{ data.posts.totalPages }}">
										<span class="glyphicon glyphicon-chevron-right"></span>
									</a>
								</li>
							{% endif %}

						</ul>
					{% endif %}
				{% else %}
					{% if data.category %}
						<h3 class="text-muted">Es gibt keine News in der Kategorie {{ data.category.name }}.</h3>
					{% else %}
						<h3 class="text-muted">Es gibt noch keine News.</h3>
					{% endif %}
				{% endif %}
			{% endif %}
		</div>
		<div class="col-lg-4">
			{% include "../includes/twitter.html.swig" %}
		</div>
		{% if data.categories.length %}
			<div class="col-sm-4 col-md-3">
				<h2>Categories</h2>
				<div class="list-group" style="margin-top: 70px;">
					{% set classAttr = "" %}
					{% if not data.category %}
						{% set classAttr = "active" %}
					{% endif %}
					<a href="/news" class="{{ classAttr }} list-group-item">All Categories</a>
					{% for cat in data.categories %}
						{% set classAttr = "" %}
						{% if data.category and data.category.id == cat.id %}
							{% set classAttr = "active" %}
						{% endif %}
						<a href="/news/{{ cat.key }}" class="{{ classAttr }} list-group-item">{{ cat.name }}</a>
					{% endfor %}
				</div>
			</div>
		{% endif %}
	</div>
</div>
{% endblock %}
