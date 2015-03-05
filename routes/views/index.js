var keystone = require('keystone'),
	moment = require('moment');

exports = module.exports = function(req, res) {
	
	var view = new keystone.View(req, res),
		locals = res.locals;
	
	// locals.section is used to set the currently selected
	// item in the header navigation.
	locals.section = 'home';
	locals.data = {
		event: [],
		talks: [],
		yesterday: moment().subtract(1, 'd')
	};

	// Load the events
	view.on('init', function(next) {

		keystone.list('Event').model.findOne()
			.where('state').in(['active', 'scheduled'])
			.sort('-publishedDate')
			.populate('location talks')
			.exec(function(err, result) {
				locals.data.event = result;
				next(err);
			});

	});

	view.on('init', function(next) {

		if (locals.data.event) {
			keystone.list('Talk').model.find().
				where('event', locals.data.event.id)
				.populate('who')
				.exec(function (err, result) {
					locals.data.talks = result;
					next(err);
				});
		} else {
			next();
		}

	});

	// Render the view
	view.render('views/index');
	
};
