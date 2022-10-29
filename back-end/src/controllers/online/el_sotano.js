const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.elsotano.com/busqueda/listaLibros.php?tipoBus=full&tipoArticulo=&palabrasBusqueda=';

const elSotanoController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}`;
        console.log('\tSearching books in El Sotano with url', url);

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let price = $('.so-bookprice').text();

        // Split price to get only the number
        price = price.split('$');

        // Get the last element of the array
        price = price[price.length - 1];

        price = Math.round(parseFloat(price) * 100) / 100;

        // This is the default price if the book is not found
        if (price == 679) return null;

        console.log('\t\tFound book with price', price);


        return price;
    }
}

module.exports = elSotanoController;