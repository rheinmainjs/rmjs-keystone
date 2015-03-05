var keystone = require('keystone');

exports = module.exports = function(req, res) {
	
	var view = new keystone.View(req, res),
		locals = res.locals;
	
	// locals.section is used to set the currently selected
	// item in the header navigation.
	locals.section = 'about';
	locals.data = {
		organizers: []
	};

	// Load the events
	view.on('init', function(next) {

		keystone.list('User').model.find()
			.where('isOrganiser', true)
			.sort('name')
			.exec(function(err, result) {
				locals.data.organizers = result;
				next(err);
			});

	});

	// Render the view
	view.render('views/about');
	
};
