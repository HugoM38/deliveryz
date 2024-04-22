const Joi = require('joi').extend(require('joi-phone-number'));

const signupCookerSchema = Joi.object({
    cookerName: Joi.string().alphanum().min(3).max(30).required(),
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net', 'fr'] } }).required(),
    password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
    address: Joi.string().required(),
    city: Joi.string().required(),
    postalCode: Joi.string().alphanum().required(),
    phoneNumber: Joi.string().phoneNumber().required(),
    menu: Joi.array().default([]),
});

module.exports = {
    validateSignupCooker: (account) => signupCookerSchema.validate(account),
};
