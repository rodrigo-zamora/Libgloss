const express = require('express');
const router = express.Router();

const { handleError } = require('../utils/hof');

const booksController = require('../controllers/books.controller');

router.get('/search', handleError(async (req, res) => {
    let books = await booksController.searchBooks(req.query);
    res.json(books);
}));

router.get('/details', handleError(async (req, res) => {
    let details = await booksController.getDetails(req.query);
    res.json(details);

    // Save the books in the database, with the current price and date
    console.log('\tSaving book details in the database...');
    console.log('\t\tISBN:', req.query.isbn);
    await booksController.saveBooks(req.query.isbn, details);
}));

router.get('/top', handleError(async (req, res) => {
    let books = await booksController.getMostPopular();
    res.json(books);
}));

router.get('/history', handleError(async (req, res) => {
    let history = await booksController.getHistory(req.query);
    res.json(history);
}));

module.exports = router;