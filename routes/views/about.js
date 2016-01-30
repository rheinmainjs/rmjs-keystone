var keystone = require('keystone');

exports = module.exports = function (req, res) {

	var view = new keystone.View(req, res),
		locals = res.locals;

	locals.section = 'about';
	locals.data = {
		organizers: []
	};

	view.on('init', function (next) {

		keystone.list('User').model.find()
			.where('isOrganiser', true)
			.sort('name')
			.exec(function (err, result) {
				locals.data.organizers = result;
				next(err);
			});

	});

	view.render('views/about');

};
