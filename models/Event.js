var keystone = require('keystone'),
	_ = require('underscore'),
	Types = keystone.Field.Types;

/**
 * Event Model
 * ==========
 */

var Event = new keystone.List('Event', {
	map: { name: 'title' },
	autokey: { path: 'slug', from: 'title', unique: true },
	defaultSort: '-eventDate'
});

Event.add({
	title: { type: String, required: true },
	publishedDate: { type: Types.Date, index: true },
	eventDateTime: { type: Types.Datetime, index: true },
	location: { type: Types.Relationship, ref: 'Venue', many: false },
	state: { type: Types.Select, options: 'draft, scheduled, active, past' },
	description: {
		brief: {type: Types.Html, wysiwyg: true, height: 150},
		extended: {type: Types.Html, wysiwyg: true, height: 400}
	},
	rsvpUrl: { label: 'Link zur Anmeldung', type: Types.Url }
});

// Relationships
// ------------------------------

Event.relationship({ ref: 'Talk', refPath: 'event', path: 'talks' });

// Virtuals
// ------------------------------

Event.schema.virtual('description.full').get(function() {
	return this.description.extended || this.description.brief;
});

// Pre Save
// ------------------------------

//Event.schema.pre('save', function(next) {
//	var event = this;
//	// If no published date, it's a draft event
//	if (!event.publishedDate) event.state = 'draft';
//	// If event date plus one day is after today, it's a past event
//	else if (moment().isAfter(moment(event.startDate).add('day', 1))) event.state = 'past';
//	// If publish date is after today, it's an active event
//	else if (moment().isAfter(event.publishedDate)) event.state = 'active';
//	// If publish date is before today, it's a scheduled event
//	else if (moment().isBefore(moment(event.publishedDate))) event.state = 'scheduled';
//	next();
//});


// Registration
// ------------------------------

Event.defaultColumns = 'title, state|10%, eventDate|15%, location|20%, publishedDate|15%';
Event.register();
