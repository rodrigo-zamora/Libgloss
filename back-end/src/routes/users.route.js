const express = require('express');
const router = express.Router();

const { handleError } = require('../utils/hof');

const usersController = require('../controllers/users.controller');

router.post('/', handleError(async (req, res) => {
    const user = await usersController.createUser(req.body);
    res.json(user);
}));

router.get('/:query', handleError(async (req, res) => {
    let user = await usersController.getUserDetails(req.params.query);
    res.json(user);
}));

router.put('/:useruid', handleError(async (req, res) => {
    let user = await usersController.updateUser(req.params.useruid, req.body);
    res.json(user);
}));

router.delete('/:useruid', handleError(async (req, res) => {
    let user = await usersController.deleteUser(req.params.useruid);
    res.json(user);
}));

module.exports = router;