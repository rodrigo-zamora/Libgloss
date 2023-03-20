class Book {
  final String id;
  final String title;
  final String thumbnail;
  final List<String> authors;
  final String publisher;
  final String? published_date;
  final List<String> images;
  final String ISBN_13;

  final DateTime created_at;
  final double latitute;
  final double longitude;
  final double price;
  final String condition;

  final String seller_id;

  Book({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.authors,
    required this.publisher,
    this.published_date,
    required this.images,
    required this.ISBN_13,
    required this.created_at,
    required this.latitute,
    required this.longitude,
    required this.price,
    required this.condition,
    required this.seller_id,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      authors: json['authors'].cast<String>(),
      publisher: json['publisher'],
      published_date: json['published_date'],
      images: json['images'].cast<String>(),
      ISBN_13: json['ISBN_13'],
      created_at: DateTime.parse(json['created_at']),
      latitute: json['latitute'],
      longitude: json['longitude'],
      price: json['price'],
      condition: json['condition'],
      seller_id: json['seller_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'authors': authors,
      'publisher': publisher,
      'published_date': published_date,
      'images': images,
      'ISBN_13': ISBN_13,
      'created_at': created_at.toIso8601String(),
      'latitute': latitute,
      'longitude': longitude,
      'price': price,
      'condition': condition,
      'seller_id': seller_id,
    };
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, thumbnail: $thumbnail, authors: $authors, publisher: $publisher, published_date: $published_date, images: $images, ISBN_13: $ISBN_13, created_at: $created_at, latitute: $latitute, longitude: $longitude, price: $price, condition: $condition, seller_id: $seller_id}';
  }
}
