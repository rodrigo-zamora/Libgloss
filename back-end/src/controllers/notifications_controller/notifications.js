const admin = require('firebase-admin');

const NotificationsController = {
    notifyUsers: async (isbn, details) => {
        
        // Get all usersuid from lists where the book is in the tracking list
        console.log('\t\tGetting users from the database...');
        let users = await admin.firestore().collection('users').get();

        // Get all usersuid from lists where the book is in the tracking list
        console.log('\t\tUsers with the book in the tracking list:', users.docs.length);
        for (let user of users.docs) {
            console.log('\t\tUser:', user.data());
        }

        const message = {
            data: {title: 'price_change', text: 'Notification from the server', isbn: isbn, details: details},
            tokens: users
        };

        console.log('\t\t\tMessage:', message);

        console.log('\t\tSending notifications...');

    },
}

module.exports = NotificationsController;