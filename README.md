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
        "_id": "6356e3f208be94e557098623",
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
        "description": "«Adoro esta novela, no pude parar de leer. Me hizo pensar acerca de los propósitos de la vida. Al final, lloré y reí.» The New York Times «Una mezcla perfecta entre Marley y yo y Martes con mi viejo profesor.» Kirkus Reviews",
        "__v": 0
    },
    {
        "_id": "6356e3f208be94e557098626",
        "title": "Razon de Estar Contigo, La. La Historia de Ellie",
        "thumbnail": "http://books.google.com/books/content?id=z7rywQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "es",
        "isbn": "9788417167066",
        "authors": [
            "W. BRUCE. CAMERON"
        ],
        "categories": [],
        "description": "Ellie is a very special dog with a very important purpose. From puppyhood, Ellie has been trained as a search-and-rescue dog. She can track down a lost child in a forest or an injured victim under a fallen building. She finds people. She saves them. It's what she was meant to do. But Ellie must do more.",
        "__v": 0
    }
]
```
-----
### **Get a list of books that match the search query.**
`GET /api/books/search?{query}`

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
`GET /api/books/details?isbn={isbn}`

Returns the price of a book in different online stores. If the book is not available in a store, or the store is not available, the price will be `null`.

#### Example
`/api/books/details?isbn=9788416867349`

#### Response
```json
{
    "amazon": 265,
    "gandhi": 334,
    "gonvill": 314.57,
    "el_sotano": 379
}
```
-----
### **Get the price history of a book.**
`GET /api/books/history?isbn={isbn}`

Returns the price history of a book. The price history is stored in a database, so it will only be available for books that have been added to the wishlist, or books that have been searched by a user.
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