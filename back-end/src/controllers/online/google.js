const bent = require('bent');

const BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=';

const googleController = {
    searchISBN: async (ISBN) => {
        let books = [];

        let url = `${BASE_URL}${ISBN}`;
        let response = await bent('json')(url);

        response.items.forEach(book => {
            console.log(book.volumeInfo.imageLinks);
            books.push({
                title: book.volumeInfo.title,
                isbn: book.volumeInfo.industryIdentifiers.find(id => id.type == 'ISBN_13').identifier,
                author: book.volumeInfo.authors
            });
        });
        return books;
    }
}

module.exports = googleController;