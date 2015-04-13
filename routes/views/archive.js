var keystone = require('keystone'),
	async = require('async');

exports = module.exports = function(req, res) {
	
	var view = new keystone.View(req, res),
		locals = res.locals;
	
	// locals.section is used to set the currently selected
	// item in the header navigation.
	locals.section = 'archive';
	
	locals.data = {
		events: [],
		eventIds: [],
		talks: []
	};

	// Load the events
	view.on('init', function(next) {

		var q = keystone.list('Event').paginate({
				page: req.query.page || 1,
				perPage: 10,
				maxPages: 10
			})
			.where('state', 'past')
			.sort('-eventDateTime')
			.populate('location talks');

		q.exec(function(err, events) {
			locals.data.events = events;
			locals.data.events.results.forEach(function (event) {
				locals.data.eventIds.push(event.id);
			});
			next(err);
		});
	});

	view.on('init', function(next) {

		keystone.list('Talk').model.find().
			where('event').in(locals.data.eventIds)
			.populate('who')
			.exec(function (err, result) {
				locals.data.talks = result;
				next(err);
			});

	});


	// Render the view
	view.render('views/archive');
	
};
