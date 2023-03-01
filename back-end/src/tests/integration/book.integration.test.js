const request = require('supertest');

const app = require('../../app');
const endFunction = require('./helpers/supertest-jasmine');

describe('Book API', () => {
    describe('GET /api/books', () => {
        it('should return a list of books', (done) => {
            request(app)
                .get('/api/books')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of N books', (done) => {
            request(app)
                .get('/api/books?page_size=2')
                .expect(200)
                .expect((res) => {
                    expect(res.body.length).toBe(2);
                })
                .end(endFunction(done));
        }),
        it('should throw an error if page_size is not a number', (done) => {
            request(app)
                .get('/api/books?page_size=abc')
                .expect(400)
                .end(endFunction(done));
        }),
        it('should throw an error if page_size is not a positive number', (done) => {
            request(app)
                .get('/api/books?page_size=-1')
                .expect(400)
                .end(endFunction(done));
        });
    }),
    describe('GET /api/books/random', () => {
        it('should return a random book', (done) => {
            request(app)
                .get('/api/books/random')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of N random books', (done) => {
            request(app)
                .get('/api/books/random?page_size=2')
                .expect(200)
                .expect((res) => {
                    expect(res.body.length).toBe(2);
                })
                .end(endFunction(done));
        }),
        it('should throw an error if page_size is not a number', (done) => {
            request(app)
                .get('/api/books/random?page_size=abc')
                .expect(400)
                .end(endFunction(done));
        }),
        it('should throw an error if page_size is not a positive number', (done) => {
            request(app)
                .get('/api/books/random?page_size=-1')
                .expect(400)
                .end(endFunction(done));
        });
    }),
    describe('GET /api/books/search', () => {
        it('should return a list of books by title', (done) => {
            request(app)
                .get('/api/books/search?title=book')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of books by category', (done) => {
            request(app)
                .get('/api/books/search?category=Terror')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of books by author', (done) => {
            request(app)
                .get('/api/books/search?author=Stephen King')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of books by ISBN 13', (done) => {
            request(app)
                .get('/api/books/search?isbn=9788416867349')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should throw an error if length of ISBN 13 is not 13', (done) => {
            request(app)
                .get('/api/books/search?isbn=978841686734')
                .expect(501)
                .end(endFunction(done));
        }),
        it('should return a list of books by publisher', (done) => {
            request(app)
                .get('/api/books/search?publisher=Planeta')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of books by title and category', (done) => {
            request(app)
                .get('/api/books/search?title=book&category=Terror')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a list of books by title, author and category', (done) => {
            request(app)
                .get('/api/books/search?title=book&author=Stephen King&category=Terror')
                .expect(200)
                .end(endFunction(done));
        });
    }),
    describe('GET /api/books/details', () => {
        it('should return a book by ISBN 13', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should throw an error if length of ISBN 13 is not 13', (done) => {
            request(app)
                .get('/api/books/details?isbn=978841686734')
                .expect(501)
                .end(endFunction(done));
        }),
        it('should return a book by ISBN 13 and by store amazon', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=amazon')
                .expect(200)
                .end(endFunction(done));
        }),
        // Not implemented yet
        /*it('should return a book by ISBN 13 and by store mercado_libre', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=mercado_libre')
                .expect(200)
                .end(endFunction(done));
        }),*/
        it('should return a book by ISBN 13 and by store gandhi', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=gandhi')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a book by ISBN 13 and by store gonvill', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=gonvill')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should return a book by ISBN 13 and by store el_sotano', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=el_sotano')
                .expect(200)
                .end(endFunction(done));
        }),
        it('should throw an error if store is not valid', (done) => {
            request(app)
                .get('/api/books/details?isbn=9788416867349&store=abc')
                .expect(400)
                .end(endFunction(done));
        }),
        it('should throw an error if length of ISBN 13 is not 13 and store is not valid', (done) => {
            request(app)
                .get('/api/books/details?isbn=978841686734&store=abc')
                .expect(501)
                .end(endFunction(done));
        });
    });
});