var keystone = require('keystone');

exports = module.exports = function(req, res) {
	
	var view = new keystone.View(req, res),
		locals = res.locals;

	// Set locals
	locals.section = 'event';
	locals.filters = {
		event: req.params.event
	};
	locals.data = {
		events: [],
		german: [],
		talks: []
	};
	
	// Load the current post
	view.on('init', function(next) {
		
		var q = keystone.list('Event').model.findOne({
			slug: locals.filters.event
		})
		.populate('location');
		
		q.exec(function(err, result) {
			locals.data.event = result;
			next(err);
		});
		
	});

	view.on('init', function(next) {
		var q = keystone.list('Talk').model
			.find()
			.where('event', locals.data.event.id)
			.populate('who');

		q.exec(function(err, result) {
			console.log(result);
			locals.data.talks = result;
			next(err);
		});
	});
	
	// Load other events
	//view.on('init', function(next) {
	//
	//	var q = keystone.list('Event').model.find().where('state', 'published').sort('-publishedDate').populate('author').limit('4');
	//
	//	q.exec(function(err, results) {
	//		locals.data.events = results;
	//		next(err);
	//	});
	//
	//});
	
	// Render the view
	view.render('views/event');
	
};
