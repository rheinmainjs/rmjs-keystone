var keystone = require('keystone'),
	async = require('async'),
	RSS = require('rss');

exports = module.exports = function(req, res) {
	
	var view = new keystone.View(req, res),
		locals = res.locals,
		feed = new RSS({
			'title': 'RheinMainJS News',
			'feed_url': 'http://localhost:3001/rss',
			'site_url': 'http://localhost:3001'
		});

	
	// Init locals
	locals.section = 'news';
	locals.filters = {
		category: req.params.category
	};
	locals.data = {
		posts: [],
		categories: [],
		xml: ''
	};
	
	// Load the posts
	view.on('init', function(next) {
		
		var q = keystone.list('Post').paginate({
				page: req.query.page || 1,
				perPage: 10,
				maxPages: 10
			})
			.where('state', 'published')
			.sort('-publishedDate')
			.populate('author categories');
		
		q.exec(function(err, results) {
			locals.data.posts = results;
			//for (item in results.results) {
			results.results.forEach(function (item) {
				feed.item({
					'title': item.title,
					'description': item.content.extended,
					'url': feed.site_url + '/news/' + item.slug,
					'date': item.publishedDate
				});
			});
			locals.data.xml = feed.xml();
			next(err);
		});
		
	});
	
	// Render the view
	view.render('views/rss');
	
};
