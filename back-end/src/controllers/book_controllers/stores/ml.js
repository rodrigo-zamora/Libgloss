const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://listado.mercadolibre.com.mx';
const mlController = {
    getPrice: async (title) => {
        let url = `${BASE_URL}/${title}`;
        console.log('\tSearching books in Mercado Libre with url', url);

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);
        const book = $('.ui-search-layout__item');
        let price = $(book).find('.price-tag-fraction').text();
        let decimal = $(book).find('.price-tag-cents').text();

        price = price + '.' + decimal;
        price = Math.round(parseFloat(price) * 100) / 100;
        console.log('\t\tFound book with price', price);

        return price;
    },
}

module.exports = mlController;