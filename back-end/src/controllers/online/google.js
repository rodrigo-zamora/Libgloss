const bent = require('bent');

const BASE_URL = 'https://www.googleapis.com/books/v1/volumes?maxResults=40&q=';

const categories = {
    "Acción": "action",
    "Aventura": "adventure",
    "Ciencia Ficción": "science-fiction",
    "Fantasía": "fantasy",
    "Misterio": "mystery",
    "Romance": "romance",
    "Terror": "horror",
    "Thriller": "thriller",
}

async function makeRequest(url, randomize) {
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

    // Randomize books for better UX
    if (randomize) books.sort(() => Math.random() - 0.5);

    return books;
}

const googleController = {
    searchTitle: async (title) => {
        console.log('\tSearching for books with title', title);

        let url = `${BASE_URL}${title}`;
        return await makeRequest(url, false);
    },
    searchCategory: async (category) => {
        console.log('\tSearching for books with category', category);

        let url = `${BASE_URL}subject:${category}`;
        return await makeRequest(url, true);
    },
    searchISBN: async (ISBN) => {
        console.log('\tSearching for books with ISBN', ISBN);

        let url = `${BASE_URL}isbn:${ISBN}`;
        return await makeRequest(url, false);
    },
    searchByPublisher: async (publisher) => {
        console.log('\tSearching for books with publisher', publisher);

        let url = `${BASE_URL}inpublisher:${publisher}`;
        return await makeRequest(url, false);
    },
    search: async (title, category, author, isbn, publisher) => {

        console.log('Searching for books with query', { title, category, author, isbn, publisher });

        let query = '';

        // Switch category name from spanish to english
        if (category) {
            category = categories[category];
        }

        if (title) query += `intitle:${title}+`;
        if (category) query += `subject:${category}+`;
        if (author) query += `inauthor:${author}+`;
        if (isbn) query += `isbn:${isbn}+`;
        if (publisher) query += `inpublisher:${publisher}+`;

        // Remove last '+' if present
        if (query.charAt(query.length - 1) == '+') query = query.slice(0, -1);
        
        let url = `${BASE_URL}${query}`;

        console.log('\tURL:', url);
        return await makeRequest(url, false);
    }
}

module.exports = googleController;