const admin = require('firebase-admin');
const googleController = require('../book_controllers/stores/google');

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

        // Get the name of the book
        let books = await googleController.searchISBN(isbn);
        let bookName = books[0].title;

        // Get only user where the book is in the tracking list
        let users = await admin.firestore().collection('lists').get();
        let tokens = [];

        for (let user of users.docs) {
            let data = user.data();
            console.log('\t\t\tUser: ' + data.useruid);

            hasNotifications = await admin.firestore().collection('users').doc(data.useruid).get().then((doc) => {
                return doc.data().notifications;
            });
            console.log('\t\t\t\tUser has notifications enabled: ' + hasNotifications);

            if (hasNotifications) {
                for (let book of data.tracking) {
                    console.log('\t\t\t\tBook: ' + book.isbn);
    
                    if (book.isbn == isbn) {
                        console.log('\t\t\t\t\tBook found in tracking list');
    
                        if (Object.values(details)[0].price <= book.price) {
                            console.log('\t\t\t\t\t\tPrice is lower than the one in the tracking list');
    
                            let stores = Object.keys(details);
                            if (book.store == 'all' || stores.includes(book.store)) {
                                console.log('\t\t\t\t\t\t\tStore is in the tracking list');
    
                                let token = await NotificationsController.getToken(data.useruid);
                                tokens.push(token);
    
                                console.log('\t\t\t\t\t\t\t\tToken: ' + token);
                            }
                        }
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
                    imageUrl: "https://smallpetselect.com/wp-content/uploads/2016/09/rabbit-reading-book.jpg",

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
                })
                .catch(error => {
                    console.log('\t\t\tError sending message:', error);
                });
            });
        }
    },
}

module.exports = NotificationsController;