const express = require('express');
const router = express.Router();

const { handleError } = require('../utils/hof');

const listsController = require('../controllers/lists.controller');

router.get('/:useruid', handleError(async (req, res) => {
    let list = await listsController.getList(req.params.useruid);
    res.json(list);
}));

router.post('/:useruid/tracking', handleError(async (req, res) => {
    let list = await listsController.createTrackingListItem(req.params.useruid, req.body);
    res.json(list);
}));

router.put('/:useruid/tracking', handleError(async (req, res) => {
    let list = await listsController.updateTrackingList(req.params.useruid, req.body);
    res.json(list);
}));

router.post('/:useruid/wish', handleError(async (req, res) => {
    let list = await listsController.createWishListItem(req.params.useruid, req.body);
    res.json(list);
}));

router.put('/:useruid/wish', handleError(async (req, res) => {
    let list = await listsController.updateWishList(req.params.useruid, req.body);
    res.json(list);
}));

router.get('/:useruid/tracking/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.getTrackingListItem(req.params.useruid, req.params.listItemuid);
    res.json(listItem);
}));

router.put('/:useruid/tracking/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.updateTrackingListItem(req.params.useruid, req.params.listItemuid, req.body);
    res.json(listItem);
}));

router.delete('/:useruid/tracking/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.deleteTrackingListItem(req.params.useruid, req.params.listItemuid);
    res.json(listItem);
}));

router.get('/:useruid/wish/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.getWishListItem(req.params.useruid, req.params.listItemuid);
    res.json(listItem);
}));

router.put('/:useruid/wish/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.updateWishListItem(req.params.useruid, req.params.listItemuid, req.body);
    res.json(listItem);
}));

router.delete('/:useruid/wish/:listItemuid', handleError(async (req, res) => {
    let listItem = await listsController.deleteWishListItem(req.params.useruid, req.params.listItemuid);
    res.json(listItem);
}));

module.exports = router;