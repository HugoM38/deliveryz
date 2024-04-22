const Joi = require('joi').extend(require('joi-phone-number'));

const signupDelivererSchema = Joi.object({
    email: Joi.string().email({ minDomainSegments: 2, tlds: { allow: ['com', 'net', 'fr'] } }).required(),
    password: Joi.string().pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
    firstname: Joi.string().alphanum().required(),
    lastname: Joi.string().alphanum().required(),
    address: Joi.string().required(),
    city: Joi.string().required(),
    postalCode: Joi.string().alphanum().required(),
    phoneNumber: Joi.string().phoneNumber().required()
});

module.exports = {
    validateSignupDeliverer: (account) => signupDelivererSchema.validate(account),
};
