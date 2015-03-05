var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Enquiry Model
 * =============
 */

var Enquiry = new keystone.List('Enquiry', {
	nocreate: true,
	noedit: true
});

Enquiry.add({
	name: { type: Types.Name, required: true },
	email: { type: Types.Email, required: true },
	phone: { type: String },
	enquiryType: { type: Types.Select, options: [
		{ value: 'message', label: 'Nur eine allgemeine Nachricht' },
		{ value: 'question', label: 'Ich habe eine Frage' },
		{ value: 'request', label: 'Ich möchte einen Vortrag halten' },
		{ value: 'other', label: 'Something completely different…' }
	] },
	message: { type: Types.Markdown, required: true },
	createdAt: { type: Date, default: Date.now }
});

Enquiry.defaultSort = '-createdAt';
Enquiry.defaultColumns = 'name, email, enquiryType, createdAt';
Enquiry.register();
