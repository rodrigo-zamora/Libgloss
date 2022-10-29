const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');
const bent = require('bent');

const BASE_URL = 'https://www.amazon.com.mx/s?k=';
const CATEGORY = "i=stripbooks";

const amzController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}&${CATEGORY}`;
        console.log('\tSearching books in Amazon with url', url);
        
        let response = await cloudscraper.get(url, {method: 'GET'});
        const $ = cheerio.load(response);
        
        const book = $('.s-result-item');

        let price = $(book).find('.a-price-whole').text();

        // Get the href of class a-link-normal where text is "Pasta blanda"
        let href = $(book).find("a.a-link-normal:contains('Pasta blanda')").attr('href');

        price = price.slice(0, -1);
        let priceArray = price.split('.');

        // Remove elements where price is 0
        priceArray = priceArray.filter(function (el) {
            return el != 0;
        });

        price = priceArray[0];

        price = Math.round(parseFloat(price) * 100) / 100;
        console.log('\t\tFound book with price', price);

        return {
            price: price,
            url: 'https://www.amazon.com.mx' + href
        };
    }
}

module.exports = amzController;