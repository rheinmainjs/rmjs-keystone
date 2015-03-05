{% extends "../layouts/default.html.swig" %}

{% block content %}
	<div class="container">
		{% if enquirySubmitted %}
			<h3>Vielen Dank für Deine Nachricht.</h3>
		{% else %}
			<div class="jumbotron text-center">
				<h1>Schreib uns!</h1>
			</div>
			<div class="row">
				<div class="col-sm-8 col-md-6 col-lg-12">
					<form id="contact" method="post">
						<input type="hidden" name="action" value="contact">
						{% if validationErrors.name %}
							{% set classAttr = "has-error" %}
						{% else %}
							{% set classAttr = "" %}
						{% endif %}
						<div class="form-group {{ classAttr }}">
							<label>
								<span>Name</span>
							</label>
							<input type="text" name="name.full" value="{{ formData.name.full }}" class="form-control" placeholder="Wie heißt du?">
						</div>
						{% if validationErrors.email %}
							{% set classAttr = "has-error" %}
						{% else %}
							{% set classAttr = "" %}
						{% endif %}
						<div class="form-group {{ classAttr }}">
							<label>
								<span>E-Mail</span>
							</label>
							<input type="email" name="email" value="{{ formData.email }}" class="form-control" placeholder="Deine E-Mail-Adresse, damit wir dich erreichen können">
						</div>
						{% if validationErrors.enquiryType %}
							{% set classAttr = "has-error" %}
						{% else %}
							{% set classAttr = "" %}
						{% endif %}
						<div class="form-group {{ classAttr }}">
							<label>
								<span>Aus welchem Grund schreibst Du uns?</span>
							</label>
							<select name="enquiryType" class="form-control">
								<option value="">(wähle einen aus)</option>
								{% for type in enquiryTypes %}
									{% if formData.enquiryType == type.value %}
										{% set selected = "selected='selected'" %}
									{% else %}
										{% set selected = "" %}
									{% endif %}
									<option value="{{ type.value }}" {{ selected }}>{{ type.label }}</option>
								{% endfor %}
							</select>
						</div>
						{% if validationErrors.message %}
							{% set classAttr = "has-error" %}
						{% else %}
							{% set classAttr = "" %}
						{% endif %}
						<div class="form-group {{ classAttr }}">
							<label>
								<span>Nachricht</span>
							</label>
							<textarea name="message" placeholder="Deine Nachricht … ;-)" rows="4" class="form-control">{{ formData.message }}</textarea>
						</div>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">Abschicken</button>
						</div>
					</form>
				</div>
			</div>
		{% endif %}
	</div>
{% endblock %}
