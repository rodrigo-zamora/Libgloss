const googleController = require('../controllers/online/google');
const mlController = require('../controllers/online/ml');
const amzController = require('../controllers/online/amz');

const booksController = {
    search: async (query) => {

        query.title = query.title.replaceAll(' ', '%20');

        let time = new Date();

        console.log('Searching books with query', query.title);

        let books = await googleController.searchISBN(query.title);
        console.log('\tFound', books.length, 'books in Google Books');
        return books;

        /*for (let i = 0; i < 1; i++) {
            let book = ISBNList[i];
            let amzPrice = await amzController.getPrice(book.isbn);
            let mlPrice = await mlController.getPrice(book.isbn);
            book.price = {
                amz: amzPrice == 0 ? null : amzPrice,
                ml: mlPrice == 0 ? null : mlPrice
            }
            books.push(book);
        }

        books.sort((a, b) => {
            if (a.price.amz == null) {
                return 1;
            } else if (b.price.amz == null) {
                return -1;
            } else {
                return a.price.amz - b.price.amz;
            }
        });*/

        let time2 = new Date();

        console.log('Took', time2 - time, 'ms to search in Google');

        return books;
    },
    getDetails: async (ISBN) => {
        console.log('Getting details of book with ISBN', ISBN)

        let amzPrice = await amzController.getPrice(ISBN);
        let mlPrice = await mlController.getPrice(ISBN);

        details = {
            amz: amzPrice == 0 ? null: amzPrice,
            ml: mlPrice == 0 ? null : mlPrice
        }
    }
}

module.exports = booksController;