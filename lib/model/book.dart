class Book {
  int? id;
  String? bookName;
  String? bookAuthor;
  int? bookPrice;

  Book({this.bookName, this.bookAuthor, this.bookPrice});

  Book.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    bookName = map['bookName'];
    bookAuthor = map['bookAuthor'];
    bookPrice = map['bookPrice'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'bookName': bookName,
        'bookAuthor': bookAuthor,
        'bookPrice': bookPrice,
      };
}
