const mongoose = require('mongoose');

const bookDetailsSchema = new mongoose.Schema({
    isbn: {
        type: String,
        required: true
    },
    stores: {
        type: Object,
        required: true
    }
}, { collection: 'book_details' });

let BookDetails = mongoose.model('BookDetails', bookDetailsSchema);

module.exports = BookDetails;