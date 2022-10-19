const bent = require('bent');

const BASE_URL = 'https://www.googleapis.com/books/v1/volumes?q=';

async function makeRequest(url) {
    let books = [];
    let response = await bent('json')(url);
    response.items.forEach(book => {
        try {
            books.push({
                title: book.volumeInfo.title,
                subtitle: book.volumeInfo.subtitle,
                rating: book.volumeInfo.averageRating,
                thumbnail: book.volumeInfo.imageLinks.thumbnail,
                language: book.volumeInfo.language,
                isbn: book.volumeInfo.industryIdentifiers.find(id => id.type == 'ISBN_13').identifier,
                authors: book.volumeInfo.authors,
                publisher: book.volumeInfo.publisher,
                categories: book.volumeInfo.categories,
                description: book.volumeInfo.description,
            });
        } catch (error) {
            console.log('\x1b[33mBook with title:', book.volumeInfo.title, 'has no ISBN_13\x1b[0m');
        }
    });
    return books;
}

const googleController = {
    searchTitle: async (title) => {
        console.log('\tSearching for books with title', title);

        let url = `${BASE_URL}${title}`;
        return await makeRequest(url);
    },
    searchCategory: async (category) => {
        console.log('\tSearching for books with category', category);

        let url = `${BASE_URL}subject:${category}`;
        return await makeRequest(url);
    },
    searchISBN: async (ISBN) => {
        console.log('\tSearching for books with ISBN', ISBN);

        let url = `${BASE_URL}isbn:${ISBN}`;
        return await makeRequest(url);
    }
}

module.exports = googleController;