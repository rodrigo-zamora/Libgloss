const googleController = require('../controllers/online/google');
const mlController = require('../controllers/online/ml');
const amzController = require('../controllers/online/amz');

const booksController = {

    // Handle search requests, including title, category, and ISBN
    searchBooks: async (query) => {
        let books = [];

        // Replace spaces with '%20' to make a valid URL
        books = await googleController.search(
            query.title ? query.title.replace(/ /g, '%20') : null,
            query.category ? query.category.replace(/ /g, '%20') : null,
            query.author ? query.author.replace(/ /g, '%20') : null,
            query.isbn ? query.isbn.replace(/ /g, '%20') : null
        );

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
    }
}

module.exports = booksController;