const Joi = require('joi');

const orderSchema = Joi.object({
    productName: Joi.string().required(),
    quantity: Joi.number().integer().min(1).required(),
    totalPrice: Joi.number().min(0).required(),
    clientId: Joi.string().required(),
    cookerId: Joi.string().required(),
    status: Joi.string().default("pending")
});

module.exports = {
    validateOrder: (order) => orderSchema.validate(order)
};
