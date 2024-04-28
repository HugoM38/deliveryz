const Joi = require('joi').extend(require('joi-phone-number'));

const signupClientSchema = Joi.object({
    firstName: Joi.string().alphanum().required(),
    lastName: Joi.string().alphanum().required(),
    address: Joi.string().required(),
    city: Joi.string().required(),
    postalCode: Joi.string().alphanum().required(),
    phoneNumber: Joi.string().phoneNumber().required(),
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net', 'fr'] } }).required(),
    password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
});

module.exports = {
    validateSignupClient: (account) => signupClientSchema.validate(account),
};
