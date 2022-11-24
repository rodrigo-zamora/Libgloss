const express = require('express');
const router = express.Router();

const { handleError } = require('../utils/hof');

const booksController = require('../controllers/book_controllers/books.controller');
const notificationsController = require('../controllers/notifications_controller/notifications');

router.get('/', handleError(async (req, res) => {
    const books = await booksController.getBooks(req.query.page_size, req.query.page);
    res.json(books);
}));

router.get('/random', handleError(async (req, res) => {
    const book = await booksController.getRandomBooks(req.query.page_size);
    res.json(book);
}));

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

    // Notify users about the price change
    console.log('\tNotifying users about the price change...');
    await notificationsController.notifyUsers(req.query.isbn, details);

}));

router.get('/history', handleError(async (req, res) => {
    let history = await booksController.getHistory(req.query);
    res.json(history);
}));

module.exports = router;