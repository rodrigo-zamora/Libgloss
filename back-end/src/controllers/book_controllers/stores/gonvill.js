const cheerio = require('cheerio');
const cloudscraper = require('cloudscraper');

const BASE_URL = 'https://www.gonvill.com.mx/busqueda/listaLibros.php?tipoBus=full&palabrasBusqueda=';

const gonvillController = {
    getPrice: async (isbn) => {
        let url = `${BASE_URL}${isbn}`;

        let response = await cloudscraper.get(url, { method: 'GET' });
        const $ = cheerio.load(response);

        let price = $('.precio').text();

        href = $('.portada').find('a').attr('href'); // Get the href of the first element with class portada

        // Split price to get only the number
        price = price.split('$');

        // Get the last element of the array
        price = price[price.length - 1];

        price = Math.round(parseFloat(price) * 100) / 100;

        if (!price) return null;

        return {
            price: price,
            url: 'https://www.gonvill.com.mx' + href
        }
    }
}

module.exports = gonvillController;