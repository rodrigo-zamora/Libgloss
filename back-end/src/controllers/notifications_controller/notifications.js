const admin = require('firebase-admin');
const googleController = require('../book_controllers/stores/google');

const notification_options = {
    priority: "high",
    timeToLive: 60 * 60 * 24
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

            for (let book of data.tracking) {
                if (book.isbn == isbn) {

                    if (Object.values(details)[0].price <= book.price) {
                        
                        let stores = Object.keys(details);
                        if (book.store == 'all' || stores.includes(book.store)) {
                            let token = await NotificationsController.getToken(data.useruid);
                            tokens.push(token);
                        }
                    }
                }
            }
        }

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

            console.log('\t\t\tMessage:', payload);
            console.log('\t\t\tTokens:', tokens);

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