const {
    NotFoundError,
    BadRequestError
} = require('../utils/errors');

const userBooksController = {
    getUserBooks: async function () {
        // Get the user books

    },

    createUserBook: async function (useruid) {
        if (!useruid) throw new BadRequestError('User UID is required');

        // Check if the user exists

        // If the user exists, create the user book and return it

    },

    getUserBook: async function (bookuid) {
        if (!bookuid) throw new BadRequestError('Book UID is required');

        // Check if the user book exists

        // If the user book exists, return it

    },

    updateUserBook: async function (bookuid, userBook) {
        if (!bookuid) throw new BadRequestError('Book UID is required');
        if (!userBook) throw new BadRequestError('User Book data to update is required');

        // Check if the user book exists

        // If the user book exists, update the user book and return it

    },

    deleteUserBook: async function (bookuid) {
        if (!bookuid) throw new BadRequestError('Book UID is required');

        // Check if the user book exists

        // If the user book exists, delete the user book and return it

    }
};

module.exports = userBooksController;