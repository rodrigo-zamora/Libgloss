const express = require('express');
const router = express.Router();

const {handleError} = require('../utils/hof');

const booksController = require('../controllers/books.controller');

router.get('/search', handleError(async (req, res) => {
    let books = await booksController.searchBooks(req.query);
    res.json(books);
}));

router.get('/details', handleError(async (req, res) => {
    let details = await booksController.getDetails(req.query);
    res.json(details);
}));

module.exports = router;