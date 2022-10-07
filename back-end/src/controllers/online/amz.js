const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');
const bent = require('bent');

const BASE_URL = 'https://www.amazon.com.mx/s?k=';
const CATEGORY = "i=stripbooks";

const amzController = {
    getPrice: async (isbn) => {
        timeStart = new Date();
        let url = `${BASE_URL}${isbn}&${CATEGORY}`;
        console.log('\tSearching books in Amazon with url', url);

        timeEnd = new Date();
        console.log('\t\tTook', timeEnd - timeStart, 'ms to search in Amazon');
        
        let response = await cloudscraper.get(url, {method: 'GET'});
        const $ = cheerio.load(response);
        const book = $('.s-result-item');
        let price = $(book).find('.a-price-whole').text();
        let decimal = $(book).find('.a-price-fraction').text();

        price = price.slice(0, -1);
        let priceArray = price.split('.');

        decimal = decimal.slice(0, -2);
        decimal = decimal.split('.')[0];

        if (priceArray.length == 1) {
            // Physical book
            price = priceArray[0] + '.' + decimal;
        } else if (priceArray.length == 2) {
            // Physical book and kindle edition
            price = priceArray[0] + '.' + decimal;
        } else {
            // Physycal book, kindle edition and ads
            price = priceArray[1] + '.' + decimal;
        } 

        price = Math.round(parseFloat(price) * 100) / 100;
        console.log('\t\tFound book with price', price);

        return price;
    },
    searchBook: async (query) => {
        let books = [];

        let url = `${BASE_URL}${query}&${CATEGORY}`;
        console.log('Searching books in Amazon with url', url);

        let response = await cloudscraper.get(url, {method: 'GET'});
        const $ = cheerio.load(response);
        const booksList = $('.s-result-item');
        console.log('\tFound', booksList.length, 'books');

        booksList.each((i, book) => {

            let bookTitle = $(book).find('.a-size-medium').text();

            if (bookTitle != '') {
                let bookData = {
                    title: bookTitle,
                    price: $(book).find('.a-price-whole').text(),
                    link: $(book).find('.a-link-normal').attr('href')
                };
                books.push(bookData);
            }
        });

        return books;
    }
}

module.exports = amzController;