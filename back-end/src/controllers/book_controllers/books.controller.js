const AWS = require('aws-sdk');
const config = require('../../config/config.js');

const googleController = require('./stores/google.js');
const amzController = require('./stores/amz.js');
const gandhiController = require('./stores/gandhi.js');
const gonvillController = require('./stores/gonvill.js');
const elSotanoController = require('./stores/el_sotano.js');

const { NotFoundError, BadRequestError, ServerError, NotImplementedError } = require('../../utils/errors.js');

const generateBookId = require('../../utils/id.js');

const booksController = {

    // Handle search requests, including title, category, and ISBN
    searchBooks: async (query) => {

        let books = [];

        // Search for books using google controller
        books = await googleController.search(
            query.title ? query.title.replace(/ /g, '%20') : null,
            query.category ? query.category : null,
            query.author ? query.author.replace(/ /g, '%20') : null,
            query.isbn ? query.isbn : null,
            query.publisher ? query.publisher : null
        );

        // If no books were found, return an empty array
        if (books.length == 0) return [];

        return books;
    },

    saveNewBooks: async (books) => {

        // Add all books to the database
        const docClient = new AWS.DynamoDB.DocumentClient();

        for (let i = 0; i < books.length; i++) {
            let book = books[i];

            let title = book.title ? book.title : '';
            let author = book.authors[0] ? book.authors[0] : '';
            let publisher = book.publisher ? book.publisher : '';

            let params = {
                TableName: config.aws_table_name,
                Key: {
                    id: book.isbn
                }
            };

            // Check if book already exists in the database
            let data = await docClient.get(params).promise();

            // If book does not exist, add it to the database
            if (Object.keys(data).length === 0) {
                let params = {
                    TableName: config.aws_table_name,
                    Item: {
                        id: generateBookId(title, author, publisher),
                        isbn: book.isbn,
                        title: book.title,
                        subtitle: book.subtitle,
                        rating: book.rating,
                        thumbnail: book.thumbnail,
                        authors: book.authors,
                        publisher: book.publisher,
                        description: book.description,
                        categories: book.categories,
                        language: book.language,
                    },
                };

                await docClient.put(params).promise();
            }

        }

    },

    // Get price and availability details for a book, given its ISBN
    getDetails: async (query) => {
        let details = {};

        if (query.isbn == null) throw new BadRequestError('ISBN is required');
        if (query.isbn.length != 13) throw new NotImplementedError('ISBN must be 13 digits long');

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
                    return { amazon: details };
                case 'gandhi':
                    details = await gandhiController.getPrice(title);
                    return { gandhi: details };
                case 'gonvill':
                    details = await gonvillController.getPrice(query.isbn);
                    return { gonvill: details };
                case 'el_sotano':
                    details = await elSotanoController.getPrice(query.isbn);
                    return { el_sotano: details };
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

    // Get all books in the database (paginated)
    getBooks: async (query) => {

        let page_size;
        let page;

        if (query.page_size) {
            page_size = parseInt(query.page_size);
            if (page_size > 100) throw new BadRequestError('Page size must be less than 100');
            if (page_size < 1) throw new BadRequestError('Page size must be greater than 0');
            if (isNaN(page_size)) throw new BadRequestError('Page size must be a number');
        } else {
            page_size = 10;
        }

        if (query.page) {
            page = parseInt(query.page);
            if (page < 1) throw new BadRequestError('Page must be greater than 0');
        } else {
            page = 1;
        }

        const docClient = new AWS.DynamoDB.DocumentClient();

        let items = [];
        let lastEvaluatedKey = null;
        let pageCounter = 0;

        const params = {
            TableName: config.aws_table_name,
            ExclusiveStartKey: lastEvaluatedKey,
            Limit: page_size,
        }

        let books;

        try {
            do {
                const result = await docClient.scan(params).promise();
                items = [...items, ...result.Items];
                lastEvaluatedKey = result.LastEvaluatedKey;

                pageCounter++;
            } while (lastEvaluatedKey && pageCounter < page);

            const startIndex = (page - 1) * page_size;
            const endIndex = page * page_size;

            books = items.slice(startIndex, endIndex);

        } catch (err) {
            console.error(err);
            throw new ServerError('Error getting books from DynamoDB');
        }

        return books;
    },

    // Get a list of random books in the database
    getRandomBooks: async (query) => {

        let page_size;

        if (query.page_size) {
            page_size = parseInt(query.page_size);
            if (page_size > 100) throw new BadRequestError('Page size must be less than 100');
            if (page_size < 1) throw new BadRequestError('Page size must be greater than 0');
            if (isNaN(page_size)) throw new BadRequestError('Page size must be a number');
        } else {
            page_size = 10;
        }

        const docClient = new AWS.DynamoDB.DocumentClient();

        let items = [];
        let lastEvaluatedKey = null;

        const params = {
            TableName: config.aws_table_name,
            ExclusiveStartKey: lastEvaluatedKey,
        }

        try {
            do {
                const result = await docClient.scan(params).promise();
                items = [...items, ...result.Items];
                lastEvaluatedKey = result.LastEvaluatedKey;
            } while (lastEvaluatedKey);

            const randomBooks = [];

            for (let i = 0; i < page_size; i++) {
                const randomIndex = Math.floor(Math.random() * items.length);
                randomBooks.push(items[randomIndex]);
            }

            return randomBooks;

        } catch (err) {
            console.error(err);
            throw new ServerError('Error getting books from DynamoDB');
        }
    },

    // Get the history of a book, given its ISBN
    getHistory: async (query) => {

        let key = {};

        // ISBN-10
        if (query.length == 10) {
            key = {
                isbn10: query
            }
        } else if (query.length == 13) {
            key = {
                isbn13: query
            }
        } else if (query.length == 25) {
            key = {
                id: query
            }
        } else {
            throw new BadRequestError('Invalid query parameter. Must be ISBN-10, ISBN-13 or ID.')
        }

        const docClient = new AWS.DynamoDB.DocumentClient();

        const params = {
            TableName: 'book_history',
            Key: key
        }

        try {
            const result = await docClient.get(params).promise();
            return result.Item;
        } catch (err) {
            console.error(err);
            throw new NotFoundError('Book not found');
        }
    },

    // Save the books in the database, with the current price and date
    saveBooks: async (isbn, book) => {

        if (price) {

            const docClient = new AWS.DynamoDB.DocumentClient();

            // Check if book exists in database
            const checkParams = {
                TableName: config.aws_table_name,
                Key: {
                    id: isbn
                }
            }

            try {
                const result = await docClient.get(checkParams).promise();
                if (result.Item) {

                    const params = {
                        TableName: config.aws_table_name,
                        Key: {
                            id: isbn
                        },
                        UpdateExpression: 'set #price = :price, #date = :date',
                        ExpressionAttributeNames: {
                            '#price': 'price',
                            '#date': 'date'
                        },
                        ExpressionAttributeValues: {
                            ':price': price,
                            ':date': new Date().toISOString()
                        }
                    }

                    try {
                        await docClient.update(params).promise();
                        console.log('Book updated in DynamoDB');
                        return true;
                    } catch (err) {
                        console.error(err);
                        throw new ServerError('Error updating book in DynamoDB');
                    }
                } else {

                    let date = new Date();

                    let bookData = {
                        TableName: config.aws_table_name,
                        Item: {
                            id: isbn,
                            price: price,
                            date: date.toISOString(),
                        },
                    }

                    console.table(bookData);

                    try {
                        //await docClient.put(bookData).promise();
                        return true;
                    } catch (err) {
                        console.error(err);
                        throw new ServerError('Error saving book to DynamoDB');
                    }
                }
            } catch (err) {
                console.error(err);
                throw new ServerError('Error getting book from DynamoDB');
            }
        }
    },

}

module.exports = booksController;