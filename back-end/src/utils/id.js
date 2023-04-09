const crypto = require('crypto');

function generateBookId(title, author, publisher) {

    const randomString = Math.random().toString(36).substring(2, 8);
    const id = `${title.replace(/\s+/g, '')}_${author.replace(/\s+/g, '')}_${publisher.replace(/\s+/g, '')}_${randomString}`.substring(0, 25).padEnd(25, 'x');

    const hash = crypto.createHash('sha256');
    hash.update(id);
    const hashedId = hash.digest('hex').substring(0, 25);

    return hashedId;
}

module.exports = generateBookId;