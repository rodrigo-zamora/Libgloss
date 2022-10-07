const express = require('express');
const router = express.Router();

const {handleError} = require('../utils/hof');

const booksController = require('../controllers/books.controller');

router.get('/search', async (req, res, next) => {
    console.log('Searching books with query', req.query);
    let books = await booksController.search(req.query);
    res.json(books);
});

module.exports = router;