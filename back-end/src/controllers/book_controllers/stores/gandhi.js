const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.gandhi.com.mx/catalogsearch/result/?q=';

const gandhiController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}`;
        console.log('\tSearching books in Gandhi with url', url);

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let price = $("meta[itemprop='price']").attr('content');
        price = Math.round(parseFloat(price) * 100) / 100;

        console.log('\t\tFound book with price', price);

        if (!price) return null;

        return {
            price: price,
            url: url
        };
    }
}

module.exports = gandhiController;