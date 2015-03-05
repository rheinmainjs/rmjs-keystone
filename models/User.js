var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * User Model
 * ==========
 */

var User = new keystone.List('User');

User.add({
	name: { type: Types.Name, required: true, index: true },
	email: { type: Types.Email, initial: true, index: true, displayGravatar: true },
	password: { type: Types.Password, initial: true },
	homepage: { type: Types.Url }
}, 'Profile', {
	isPublic: { type: Boolean, default: true },
	isOrganiser: Boolean,
	github: { type: String, width: 'short' },
	twitter: { type: String, width: 'short' },
	website: { type: Types.Url },
	gravatar: { type: String, noedit: true }
}, 'Permissions', {
	isAdmin: { type: Boolean, label: 'Can access Keystone', index: true }
});

// Provide access to Keystone
User.schema.virtual('canAccessKeystone').get(function() {
	return this.isAdmin;
});


/**
 * Relationships
 */

User.relationship({ ref: 'Post', path: 'posts', refPath: 'author' });
User.relationship({ ref: 'Talk', path: 'talks', refPath: 'who' });


/**
 * Registration
 */

User.defaultColumns = 'name, email, isAdmin';
User.register();
