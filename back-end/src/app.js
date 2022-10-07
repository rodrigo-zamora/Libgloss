const express = require('express');

const {
    NotFoundError,
    ConflictError,
    BadRequestError,
    ForbiddenError,
    UnauthorizedError
} = require('./utils/errors');

const app = express();

app.use(express.json());

app.use('/api/books', require('./routes/books.route'));

app.use((err, req, res, next) => {
    if (err.details) return res.status(400).json({ error: err.details[0].message });

    if (err instanceof NotFoundError) return res.status(404).json({ notFound: err.message });
    if (err instanceof ConflictError) return res.status(409).json({ conflict: err.message });
    if (err instanceof BadRequestError) return res.status(400).json({ badRequest: err.message });
    if (err instanceof ForbiddenError) return res.status(403).json({ forbidden: err.message });
    if (err instanceof UnauthorizedError) return res.status(401).json({ unauthorized: err.message });

    return res.status(500).json({ error: err.message });
});

module.exports = app;