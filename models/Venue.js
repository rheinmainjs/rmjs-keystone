var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Venue Model
 * ==========
 */

var Venue = new keystone.List('Venue', {
	map: { name: 'title' },
	autokey: { path: 'slug', from: 'title', unique: true }
});

Venue.add({
	title: { type: String, required: true },
	streetaddress: { type: String },
	zip: { type: String },
	city: { type: String },
	twitter: { type: String, width: 'short' },
	website: { type: Types.Url },
	geo: {
		latitude: { type: Types.Number },
		longitude: { type: Types.Number }
	}
});

Venue.relationship({ ref: 'Event', path: 'locations' });

Venue.defaultColumns = 'title, street|20%, housenumber|3%, zip|5%, city|20%';
Venue.register();
