const googleController = require('../controllers/online/google');
const mlController = require('../controllers/online/ml');
const amzController = require('../controllers/online/amz');
const gandhiController = require('../controllers/online/gandhi');
const gonvillController = require('../controllers/online/gonvill');
const elSotanoController = require('../controllers/online/el_sotano');

const Book = require('../models/book');
const BookDetails = require('../models/book_details');
const { NotFoundError, BadRequestError } = require('../utils/errors');

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

        store = query.store;
        if (store) {
            switch (store) {
                case 'mercado_libre':
                    details = await mlController.getPrice(title);
                    return { mercado_libre: details ? details : null };
                case 'amazon':
                    details = await amzController.getPrice(query.isbn);
                    return { amazon: details};
                case 'gandhi':
                    details = await gandhiController.getPrice(title);
                    return { gandhi: details};
                case 'gonvill':
                    details = await gonvillController.getPrice(query.isbn);
                    return { gonvill: details};
                case 'el_sotano':
                    details = await elSotanoController.getPrice(query.isbn);
                    return { el_sotano: details};
                default:
                    throw new BadRequestError('Store not found. Possible stores: mercado_libre, amazon, gandhi, gonvill, el_sotano');
            }
        } else {
            let amzPrice;
        try {
            amzPrice = await amzController.getPrice(query.isbn);
        } catch (err) {
            console.log('\t\tError getting price from Amazon:', err);
        }

        // TODO: Fix mercado libre price
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
        try {
            elSotanoPrice = await elSotanoController.getPrice(query.isbn);
        } catch (err) {
            console.log('\t\tError getting price from El Sotano:', err);
        }

        if (query.isbn) {
            details.amazon = amzPrice ? amzPrice : null;
            //details.mercado_libre = mlPrice ? mlPrice : null;
            details.gandhi = gandhiPrice ? gandhiPrice : null;
            details.gonvill = gonvillPrice ? gonvillPrice : null;
            details.el_sotano = elSotanoPrice ? elSotanoPrice : null;
        }
        
        return details;
        }
    },

    // Get a list of all books in the database
    getBooks: async (page_size, page) => {
        console.log('\tGetting books from the database...');
        if (!page_size) page_size = 10;
        if (!page) page = 1;

        console.log('\t\tPage size:', page_size);
        console.log('\t\tPage:', page);

        let books = await Book.find().skip(parseInt(page_size) * (parseInt(page) - 1)).limit(parseInt(page_size));
        return books;
    },

    // Get a list of random books in the database
    getRandomBooks: async (page_size) => {
        console.log('\tGetting random books from the database...');
        if (!page_size) page_size = 10;

        console.log('\t\tPage size:', page_size);

        let books = await Book.aggregate([{ $sample: { size: parseInt(page_size) } }]);

        return books;
    },

    // Get the history of a book, given its ISBN
    getHistory: async (query) => {
        let history = await BookDetails.findOne({ isbn: query.isbn });
        if (!history) {
            throw new NotFoundError('No history found for this book');
        } else {
            return {
                isbn: history.isbn,
                stores: history.stores
            }
        }
    },

    // Save the books in the database, with the current price and date
    saveBooks: async (isbn, details) => {

        if (details) {
            // Check if the book is already in the database
            let bookInDb = await BookDetails.findOne({ isbn: isbn });
            console.log('Creating new record for book:', isbn + '...');


            // If the book is not in the database, create a new record
            if (!bookInDb) {
                console.log('Book not in database, creating new record...');
                let bookDetails = {
                    isbn: isbn,
                    stores: {}
                };
                bookInDb = await BookDetails.create(bookDetails);
            }


            for (let store in details) {
                let price = details[store].price;
                
                if (price) {
                    let storeData = {
                        price: price,
                        date: new Date()
                    };
                    console.log('\tAdding price from', store, ':', price);
                
                    // Check if the store is already in the database
                    if (bookInDb.stores[store]) {
                        console.log('\tStore already in database, checking last price...');
                        let lastPrice = bookInDb.stores[store].data[bookInDb.stores[store].data.length - 1].price;

                        if (lastPrice != price) {
                            console.log('\tPrice changed, adding new record...');
                            bookInDb.stores[store].data.push(storeData);
                        } else {
                            console.log('\tPrice did not change, not adding new record...');
                        }

                        
                    } else {
                        console.log('\tStore not in database, creating new record...');
                        
                        bookInDb.stores[store] = {
                            data: [storeData]
                        };
                    }

                }
            }
            
            // Save the book in the database
            bookInDb.markModified('stores');
            await bookInDb.save();

            console.log(bookInDb);
            console.log('Book saved successfully!');
            }
    },

}

module.exports = booksController;