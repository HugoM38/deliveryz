const Joi = require('joi');

const menuItemSchema = Joi.object({
    id: Joi.number(),
    name: Joi.string().required(),
    price: Joi.number().min(0).required(),
});

module.exports = {
    validateMenuItem: (order) => menuItemSchema.validate(order)
};
