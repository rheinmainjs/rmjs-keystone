{% extends "../layouts/default.html.swig" %}

{% block intro %}
<div class="container">
<div class="jumbotron text-center">
	{% if data.category %}
		<h1>{{ data.category.name }}</h1>
	{% else %}
		<h1><span class='rmjs'>RheinMainJS</span> News</h1>
	{% endif %}
</div>
</div>
{% endblock %}

{% block content %}
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<article>
					<p>
						<a href="/news">&larr; Zurück zur Übersicht</a>
					</p>
					<hr>
					{% if not data.post %}
						<h2>Invalid Post.</h2>
					{% else %}
						<header>
							<h1>{{ data.post.title }}</h1>
							<h6>Geschrieben
							{% if data.post.publishedDate %}
								am {{ data.post._.publishedDate.format("DD. MMMM YYYY") }}
							{% endif %}
							{% if data.post.categories and data.post.categories.length %}
								in
								{% for cat in data.post.categories %}<a href="/news/{{ cat.key }}">{{ cat.name }}</a>{% if loop.index < data.post.categories.length %}, {% endif %}{% endfor %}
											{% endif %}
							{% if data.post.author %}
								von {{ data.post.author.name.first }}
							{% endif %}
							</h6>
						</header>
						<div class="post">
							{% if data.post.image.exists %}
								<div class="image-wrap">
									<img src="{{ data.post._.image.fit(750,450) }}" class="img-responsive">
								</div>
							{% endif %}
							{{ data.post.content.full|safe }}
						</div>
					{% endif %}
				</article>
			</div>
		</div>
	</div>
{% endblock %}
