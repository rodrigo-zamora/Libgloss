# **Libgloss**
Libgloss is an app that allows you to search for books in different online stores and compare prices. You can also add books to your wishlist and see the price history of the books you have already bought or are interested in.
## **Features**
* Search for books in different online stores
* Compare prices
* Add books to your wishlist
* See the price history of the books you have already bought or are interested in
## **Screenshots**
## **Endpoints**
### **Get books.**
`GET /api/books`

Returns a list of books. Since the books are stored in a database, the list is paginated. The default page size is 10. You can change the page size by adding the `page_size` query parameter. You can also change the page by adding the `page` query parameter.
* `page_size` - The page size. Default: 10
* `page` - The page number. Default: 1
#### Example
`/api/books?page_size=2`

#### Response
```json
[
    {
        "title": "La razón de estar contigo",
        "subtitle": "Una novela para humanos",
        "rating": 4.5,
        "thumbnail": "http://books.google.com/books/content?id=1USRDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
        "language": "es",
        "isbn": "9788416867295",
        "authors": [
            "W. Bruce Cameron"
        ],
        "publisher": "Roca editorial",
        "categories": [
            "Fiction"
        ],
        "description": "«Adoro esta novela, no pude parar de leer. Me hizo pensar acerca de los propósitos de la vida...",
    },
    {
        "title": "Razon de Estar Contigo, La. La Historia de Ellie",
        "thumbnail": "http://books.google.com/books/content?id=z7rywQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "es",
        "isbn": "9788417167066",
        "authors": [
            "W. BRUCE. CAMERON"
        ],
        "categories": [],
        "description": "Ellie is a very special dog with a very important purpose. From puppyhood...",
    }
]
```
-----
### **Get a list of random books from the database**
`GET /api/books/random`
#### Possible query parameters
* `page_size` - The page size. Default: 10
#### Example
`/api/books/random?page_size=2`
#### Response
```json
[
    {
        "title": "The Antics of Ekunyuk, the Squirrel",
        "subtitle": "Folktales From The Iteso Of Kenya.",
        "thumbnail": "http://books.google.com/books/content?id=6Hx6zQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "en",
        "isbn": "9798646856211",
        "authors": [
            "Eumot Bon"
        ],
        "categories": [],
        "description": "The story of Okunyuk, the Squirrel, was loved by the preteens in the land...",
    },
    {
        "title": "And Then There Were None",
        "subtitle": "LitPlan Teacher Pack",
        "thumbnail": "http://books.google.com/books/content?id=iowYNQAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "en",
        "isbn": "9781602490307",
        "authors": [
            "Susan R Woodward",
            "Teacher's Pet Publications"
        ],
        "categories": [],
        "description": "Essentially a complete teacher's manual for the novel, this LitPlan Teacher Pack includes...",
    }
]
```
-----
### **Get a list of books that match the search query.**
`GET /api/books/search`
#### Possible query parameters:
* `title` - the title of the book
* `category` - the category of the book.
    * List of possible categories: `Acción`, `Aventura`, `Ciencia Ficción`, `Fantasía`, `Misterio`, `Romance`, `Terror`, `Thriller`
* `author` - the author of the book
* `isbn` - the ISBN of the book
* `publisher` - the publisher of the book

#### Example
`/api/books/search?title=1984`

#### Response
```json
[
    {
        "title": "The Sino-Japanese War of 1894-1895",
        "subtitle": "Perceptions, Power, and Primacy",
        "rating": 3,
        "thumbnail": "http://books.google.com/books/content?id=dFhP3Hv83OoC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
        "language": "en",
        "isbn": "9780521817141",
        "authors": [
            "S. C. M. Paine",
            "Sarah C. M. Paine"
        ],
        "publisher": "Cambridge University Press",
        "categories": [
            "History"
        ],
        "description": "Table of contents"
    }
]
```
-----
### **Get the price of a book in different online stores.**
`GET /api/books/details`

Returns the price of a book in different online stores. If the book is not available in a store, or the store is not available, the price will be `null`.

Possible query parameters:
* `isbn` - the ISBN of the book
* `store` - get the price of a book only in that store.
    * List of possible stores: `amazon`, `mercado_libre`, `gandhi`, `gonvill`, `el_sotano`

#### Example
`/api/books/details?isbn=9788416867349`

#### Response
```json
{
    "amazon": {
        "price": 314,
        "url": "https://www.amazon.com.mx/raz%C3%B3n-estar-contigo-Bruce-Cameron/dp/8416867348/ref=sr_1_1?keywords=9788416867349&qid=1667062120&qu=eyJxc2MiOiIwLjAwIiwicXNhIjoiMC4wMCIsInFzcCI6IjAuMDAifQ%3D%3D&s=books&sr=1-1"
    },
    "gandhi": {
        "price": 334,
        "url": "https://www.gandhi.com.mx/la-razon-de-estar-contigo"
    },
    "gonvill": {
        "price": 314.57,
        "url": "https://www.gonvill.com.mx/libro/la-razon-de-estar-contigo_16350398"
    },
    "el_sotano": {
        "price": 379,
        "url": "https://www.elsotano.com/libro/la-razon-de-estar-contigo_10500797"
    }
}
```
-----
### **Get the price history of a book.**
`GET /api/books/history`

Returns the price history of a book. The price history is stored in a database, so it will only be available for books that have been added to the wishlist, or books that have been searched by a user.

Possible query parameters:
* `isbn` - the ISBN of the book
#### Example
`/api/books/history?isbn=9788416867349`
#### Response
```json
[
    {
        "isbn": "9788416867349",
        "stores": {
            "amazon": {
                "data": [
                    {
                        "price": 265,
                        "date": "2022-10-25T02:09:30.158Z"
                    }
                ]
            },
            "gandhi": {
                "data": [
                    {
                        "price": 334,
                        "date": "2022-10-25T02:09:30.158Z"
                    }
                ]
            },
            "gonvill": {
                "data": [
                    {
                        "price": 314.57,
                        "date": "2022-10-25T02:09:30.158Z"
                    }
                ]
            },
            "el_sotano": {
                "data": [
                    {
                        "price": 379,
                        "date": "2022-10-25T02:09:30.159Z"
                    }
                ]
            }
        }
    }
]
```