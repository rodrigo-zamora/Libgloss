//const List = require('../models/list.model');

const {
    NotFoundError,
    BadRequestError
} = require('../utils/errors');

const listsController = {
    getList: async function (useruid) {
        if (!useruid) throw new BadRequestError('User UID is required');

        // Get the user's list
        
        // If the user does not have a list, create tracking and wish lists
        
    },

    createTrackingListItem: async function (useruid, listItem) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItem) throw new BadRequestError('List Item is required');

        // Check if the user exists

        // If the user exists, create the tracking list item and return it

    },

    updateTrackingList: async function (useruid, list) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!list) throw new BadRequestError('List data to update is required');

        // Check if the user exists

        // If the user exists, update the tracking list and return it

    },

    createWishListItem: async function (useruid, listItem) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItem) throw new BadRequestError('List Item is required');

        // Check if the user exists

        // If the user exists, create the wish list item and return it

    },

    updateWishList: async function (useruid, list) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!list) throw new BadRequestError('List data to update is required');

        // Check if the user exists

        // If the user exists, update the wish list and return it

    },

    getTrackingListItem: async function (useruid, listItemuid) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');

        // Check if the user exists

        // If the user exists, get the tracking list item and return it

    },

    updateTrackingListItem: async function (useruid, listItemuid, listItem) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');
        if (!listItem) throw new BadRequestError('List Item data to update is required');

        // Check if the user exists

        // If the user exists, update the tracking list item and return it

    },

    deleteTrackingListItem: async function (useruid, listItemuid) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');

        // Check if the user exists

        // If the user exists, delete the tracking list item and return it

    },

    getWishListItem: async function (useruid, listItemuid) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');

        // Check if the user exists

        // If the user exists, get the wish list item and return it

    },

    updateWishListItem: async function (useruid, listItemuid, listItem) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');
        if (!listItem) throw new BadRequestError('List Item data to update is required');

        // Check if the user exists

        // If the user exists, update the wish list item and return it

    },

    deleteWishListItem: async function (useruid, listItemuid) {
        if (!useruid) throw new BadRequestError('User UID is required');
        if (!listItemuid) throw new BadRequestError('List Item UID is required');

        // Check if the user exists

        // If the user exists, delete the wish list item and return it

    }
};

module.exports = listsController;