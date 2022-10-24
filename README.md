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
### **Get the top searches.**
`GET /api/books/top`

Returns the top 10 searches, sorted by the rating of the books that match the search query.
### Response
```json
[
    {
        "title": "It Ends With Us (versione italiana)",
        "rating": 5,
        "thumbnail": "http://books.google.com/books/content?id=rmdcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "it",
        "isbn": "9788892742444",
        "authors": [
            "Colleen Hoover"
        ],
        "publisher": "SPERLING & KUPFER",
        "categories": [
            "Fiction"
        ],
        "description": "UN CASO EDITORIALE INTERNAZIONALE NATO DAL PASSAPAROLA. UNA STORIA UNICA E COMMOVENTE, IMPOSSIBILE DA DIMENTICARE...",
    },
    {
        "title": "The Gospel According to Harry Potter",
        "subtitle": "The Spiritual Journey of the World's Greatest Seeker",
        "rating": 5,
        "thumbnail": "http://books.google.com/books/content?id=C5qdiQE2g9sC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
        "language": "en",
        "isbn": "9780664236588",
        "authors": [
            "Connie Neal"
        ],
        "publisher": "Westminster John Knox Press",
        "categories": [
            "Religion"
        ],
        "description": "Tagline: Now Exploring Books One through Seven",
    },
    {
        "title": "Harry Potter: A History of Magic",
        "rating": 5,
        "thumbnail": "http://books.google.com/books/content?id=0rOWtgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
        "language": "en",
        "isbn": "9781338311501",
        "authors": [
            "British Library"
        ],
        "publisher": "Arthur A. Levine Books",
        "categories": [
            "Juvenile Nonfiction"
        ],
        "description": "The official companion book to the special exhibition Harry Potter: A History of Magic, featuring an extraordinary treasure trove of magical artifacts...",
    }
]
```
