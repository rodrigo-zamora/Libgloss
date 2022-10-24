const googleController = require('../controllers/online/google');
const mlController = require('../controllers/online/ml');
const amzController = require('../controllers/online/amz');
const Book = require('../models/book');

const booksController = {

    // Handle search requests, including title, category, and ISBN
    searchBooks: async (query) => {
        let books = [];

        // Replace spaces with '%20' to make a valid URL
        books = await googleController.search(
            query.title ? query.title.replace(/ /g, '%20') : null,
            query.category ? query.category : null,
            query.author ? query.author.replace(/ /g, '%20') : null,
            query.isbn ? query.isbn : null,
            query.publisher ? query.publisher : null
        );

        // Add all books to the database
        for (let i = 0; i < books.length; i++) {
            let book = books[i];
            let bookInDb = await Book.findOne({ isbn: book.isbn });
            if (!bookInDb) {
                await Book.create(book);
            }
        }

        return books;
    },

    // Get price and availability details for a book, given its ISBN
    getDetails: async (query) => {
        let details = {};
        let amzPrice = await amzController.getPrice(query.isbn);
        //let mlPrice = await mlController.getPrice(query.isbn);
        if (query.isbn) {
            details.amazon = amzPrice ? amzPrice : null;
            //details.ml = mlPrice ? mlPrice : null;
        }
        return details;
    },

    // Get the most popular books
    getMostPopular: async () => {
        console.log('Getting most popular books...');
        let books = await Book.find({}).sort({ rating: -1 }).limit(10);
        return books;
    },

}

module.exports = booksController;