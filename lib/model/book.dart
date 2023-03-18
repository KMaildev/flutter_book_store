class Book {
  int? id;
  String? bookName;
  String? bookAuthor;
  int? bookPrice;
  String? bookImage;

  Book({this.bookName, this.bookAuthor, this.bookPrice, this.bookImage});

  Book.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    bookName = map['bookName'];
    bookAuthor = map['bookAuthor'];
    bookPrice = map['bookPrice'];
    bookImage = map['bookImage'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookName': bookName,
        'bookAuthor': bookAuthor,
        'bookPrice': bookPrice,
        'bookImage': bookImage,
      };
}
