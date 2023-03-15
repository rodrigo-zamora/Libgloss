//const User = require('../models/user.model');

const {
    NotFoundError,
    BadRequestError
} = require('../utils/errors');

const usersController = {
    getUserDetails: async function (query) {
        if (!query) throw new BadRequestError('User UID is required');

        // If the query is an email, get the user by email
        if (query.includes('@')) {

        } else {
            // If the query is not an email, get the user by useruid

        }
    },

    createUser: async function (user) {
        if (!user) throw new BadRequestError('User is required');

        // Check if the user already exists (by email)

        // If the user does not exist, create the user and return it

    },

    updateUser: async function (useruid, user) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!user) throw new BadRequestError('User data to update is required');

        // Check if the user exists

        // If the user exists, update the user and return it

    },

    deleteUser: async function (useruid) {
        if (!useruid) throw new BadRequestError('User UID is required');

        // Check if the user exists

        // If the user exists, delete the user and return it

    }
};

module.exports = usersController;