const admin = require('firebase-admin');

const notification_options = {
    priority: "high",
    timeToLive: 60 * 60 * 24
};

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

        let tokens = users.docs.map(user => user.data().token);

        let message = {
            notification: {
                title: 'book-tracker',
                body: {
                    isbn: isbn,
                    details: details,
                },
            },
        }

        console.log('\t\t\tMessage:', message);
        console.log('\t\t\tTokens:', tokens);

        console.log('\t\tSending notifications...');
        /*admin.messaging().sendToDevice(tokens, message, notification_options).then((response) => {
            console.log('\t\tNotifications sent successfully:', response);
        }).catch((error) => {
            console.log('\t\tError sending notifications:', error);
        });*/
    },
}

module.exports = NotificationsController;