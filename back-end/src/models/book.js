const mongoose = require('mongoose');

const bookSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    subtitle: {
        type: String,
        required: false
    },
    rating: {
        type: Number,
        required: false
    },
    thumbnail: {
        type: String,
        required: false
    },
    language: {
        type: String,
        required: false
    },
    isbn: {
        type: String,
        required: false
    },
    authors: {
        type: [String],
        required: false
    },
    publisher: {
        type: String,
        required: false
    },
    categories: {
        type: [String],
        required: false
    },
    description: {
        type: String,
        required: false
    },
}, { collection: 'books' });

let Book = mongoose.model('Book', bookSchema);

module.exports = Book;