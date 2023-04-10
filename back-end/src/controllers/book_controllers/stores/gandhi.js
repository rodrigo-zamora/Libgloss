const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.gandhi.com.mx/catalogsearch/result/?q=';

const gandhiController = {
    getPrice: async (bookTitle) => {
        let url = `${BASE_URL}${bookTitle}`;

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let item = $(".search.results").find(".product-item-info")[0];

        let price = $(item).find(".price").text();
        
        let itemUrl = $(item).find("a").attr("href");

        price = parseFloat(price.replace('$', '').replace(',', ''));
        
        if (!price) return null;

        return {
            price: price,
            url: itemUrl
        };
    }
}

module.exports = gandhiController;