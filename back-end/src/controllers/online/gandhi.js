const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.gandhi.com.mx/';

const gandhiController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}`;
        console.log('\tSearching books in Gandhi with url', url);

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let price = $("meta[itemprop='price']").attr('content');
        console.log('\t\tFound book with price', price);

        price = Math.round(parseFloat(price) * 100) / 100;

        return price;
    }
}

module.exports = gandhiController;