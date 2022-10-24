const googleController = require('../controllers/online/google');
const mlController = require('../controllers/online/ml');
const amzController = require('../controllers/online/amz');
const gandhiController = require('../controllers/online/gandhi');
const gonvillController = require('../controllers/online/gonvill');

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

        // Get the title of the book
        let books = await booksController.searchBooks({ isbn: query.isbn });
        let title = books[0].title;
        title = title.replace(/ /g, '-');

        // Replace uppercase letters with lowercase
        title = title.toLowerCase();

        // Replace special characters with their equivalent
        title = title.replace(/á/g, 'a');
        title = title.replace(/é/g, 'e');
        title = title.replace(/í/g, 'i');
        title = title.replace(/ó/g, 'o');
        title = title.replace(/ú/g, 'u');
        title = title.replace(/ñ/g, 'n');

        let amzPrice;
        try {
            amzPrice = await amzController.getPrice(query.isbn);
        } catch (err) {
            console.log('\t\tError getting price from Amazon:', err);
        }

        /*let mlPrice;
        try {
            // Mercado Libre doesn't accept ISBNs, so we need to search by title
            mlPrice = await mlController.getPrice(title);
        } catch (err) {
            console.log('\t\tError getting price from Mercado Libre:', err);
        }*/

        let gandhiPrice;
        try {

            // Search using title to get the physical book
            gandhiPrice = await gandhiController.getPrice(title);
        } catch (err) {
            console.log('\t\tError getting price from Gandhi:', err);
        }

        let gonvillPrice;
        try {
            gonvillPrice = await gonvillController.getPrice(query.isbn);
        } catch (err) {
            console.log('\t\tError getting price from Gonvill:', err);
        }

        let elSotanoPrice;

        if (query.isbn) {
            details.amazon = amzPrice ? amzPrice : null;
            //details.mercado_libre = mlPrice ? mlPrice : null;
            details.gandhi = gandhiPrice ? gandhiPrice : null;
            details.gonvill = gonvillPrice ? gonvillPrice : null;
            details.el_sotano = elSotanoPrice ? elSotanoPrice : null;
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