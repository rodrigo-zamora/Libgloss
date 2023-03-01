const admin = require('firebase-admin');

const notification_options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
    show_in_foreground: true
};


const NotificationsController = {
    getToken: async (useruid) => {
        let user = await admin.firestore().collection('users').doc(useruid).get();
        return user.data().token;
    },
    notifyUsers: async (isbn, details) => {

        let tokens = [];

        // Get the document from book_notifications where the field bookISBN is equal to the isbn
        let book = await admin.firestore().collection('book_notifications').doc(isbn).get();

        // If the document doesn't exist, no users are tracking this book
        if (!book.exists) {
            console.log('\t\tNo users are tracking this book');
            return;
        }

        // Get the list of users that are tracking this book
        let users = book.data().users;

        // Get the token of each user and add it to the tokens array
        for (let user of users) {
            console.log('\t\t\tUser ' + user);

            let hasNotifications = await admin.firestore().collection('users').doc(user).get().then((doc) => {
                return doc.data().notifications;
            });

            if (hasNotifications) {
                let desiredPrice = await admin.firestore().collection('users').doc(user).collection('tracking').doc(isbn).get().then((doc) => {
                    return doc.data().price;
                });

                if (Object.values(details)[0].price <= desiredPrice) {
                    let stores = Object.keys(details);
                    let desiredStore = await admin.firestore().collection('users').doc(user).collection('tracking').doc(isbn).get().then((doc) => {
                        return doc.data().store;
                    });

                    if (desiredStore == 'all' || stores.includes(desiredStore)) {
                        let token = await NotificationsController.getToken(user);
                        tokens.push(token);
                    }
                }
            }
        }

        console.log('\t\t\tTokens: ' + tokens);
        if (tokens.length > 0) {

            let payload = {
                notification: {
                    title: 'Seguimiento de libros',
                    body: 'El libro ' + bookName + ' está disponible en ' + Object.keys(details).join(', ') + ' por ' + Object.values(details)[0].price + '$',
                },
                data: {
                    isbn: isbn,
                }
            }

            console.log('\t\t\tPayload', payload);

            console.log('\t\tSending notifications...');

            tokens.forEach(token => {
                admin.messaging().sendToDevice(token, payload, notification_options)
                .then(response => {
                    console.log('\t\t\tSuccessfully sent message:', response);
                    console.log(response.error);
                })
                .catch(error => {
                    console.log('\t\t\tError sending message:', error.message);
                });
            });
        }
    },
}

module.exports = NotificationsController;