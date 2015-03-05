// Simulate config options from your production environment by
// customising the .env file in your project's root folder.
require('dotenv').load();

// Require keystone
var keystone = require('keystone'),
	swig = require('swig');

// Initialise Keystone with your project's configuration.
// See http://keystonejs.com/guide/config for available options
// and documentation.

keystone.init({

	'name': 'RheinMainJS',
	'brand': 'RheinMainJS',
	
	'sass': 'public',
	'static': 'public',
	'favicon': 'public/favicon.ico',
	'views': 'templates',

	'auto update': true,
	'session': true,
	'auth': true,
	'user model': 'User',
	'cookie secret': '6mRV>T|vinsCw9a5VcPPpz]z>T}gA@JPZ+)LbAbyuG<lNHN9P@m`a`F2l@Lu{w,`',
	'cloudinary config': 'cloudinary://333779167276662:_8jbSi9FB3sWYrfimcl8VKh34rI@keystone-demo'

});

// Load your project's Models

keystone.import('models');

// Setup common locals for your templates. The following are required for the
// bundled templates and layouts. Any runtime locals (that should be set uniquely
// for each request) should be added to ./routes/middleware.js

keystone.set('locals', {
	_: require('underscore'),
	env: keystone.get('env'),
	utils: keystone.utils,
	editable: keystone.content.editable
});

keystone.set('view engine', 'html.swig');
keystone.set('custom engine', swig.renderFile);

// Load your project's Routes

keystone.set('routes', require('./routes'));

// Setup common locals for your emails. The following are required by Keystone's
// default email templates, you may remove them if you're using your own.

// Configure the navigation bar in Keystone's Admin UI

keystone.set('nav', {
	'posts': ['posts', 'post-categories'],
	'enquiries': 'enquiries',
	'users': 'users'
});

// Start Keystone to connect to your database and initialise the web server

keystone.start();
