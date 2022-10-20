# **Libgloss**
Libgloss is an app that allows you to search for books in different online stores and compare prices. You can also add books to your wishlist and see the price history of the books you have already bought or are interested in.
## **Features**
* Search for books in different online stores
* Compare prices
* Add books to your wishlist
* See the price history of the books you have already bought or are interested in
## **Screenshots**
## **Endpoints**
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

#### Example
`/api/books/details?isbn=9780521817141`

#### Response
```json
{
    "amazon": 129,
    "mercadolibre": 119,
}
```