const Joi = require('joi');

module.exports = (err, req, res, next) => {
    console.error('Error status:', err.status);
    console.error('Error message:', err.message);
    console.error('Full error:', err);

    if (err && err.isJoi) {
        return res.status(400).json({
            message: "Validation failed",
            errors: err.details
        });
    }

    res.status(err.status || 500).json({
        message: err.message || "Something went wrong",
        error: process.env.NODE_ENV === 'development' ? err : undefined
    });
};
