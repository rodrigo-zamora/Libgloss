const express = require('express');
const router = express.Router();

const { handleError } = require('../utils/hof');

const userBooksController = require('../controllers/userbooks.controller');

router.get('/', handleError(async (req, res) => {
    let userBooks = await userBooksController.getUserBooks();
    res.json(userBooks);
}));

router.post('/:useruid', handleError(async (req, res) => {
    let userBook = await userBooksController.createUserBook(req.params.useruid, req.body);
    res.json(userBook);
}));

router.get('/:bookuid', handleError(async (req, res) => {
    let userBook = await userBooksController.getUserBook(req.params.bookuid);
    res.json(userBook);
}));

router.put('/:bookuid', handleError(async (req, res) => {
    let userBook = await userBooksController.updateUserBook(req.params.bookuid, req.body);
    res.json(userBook);
}));

router.delete('/:bookuid', handleError(async (req, res) => {
    let userBook = await userBooksController.deleteUserBook(req.params.bookuid);
    res.json(userBook);
}));

module.exports = router;