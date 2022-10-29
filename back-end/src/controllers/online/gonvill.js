const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.gonvill.com.mx/busqueda/listaLibros.php?tipoBus=full&palabrasBusqueda=';

const gonvillController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}`;
        console.log('\tSearching books in Gonvill with url', url);

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let price = $('.precio').text();

        // Split price to get only the number
        price = price.split('$');

        // Get the last element of the array
        price = price[price.length - 1];

        price = Math.round(parseFloat(price) * 100) / 100;

        console.log('\t\tFound book with price', price);

        return price;
    }
}

module.exports = gonvillController;