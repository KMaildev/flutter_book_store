import 'package:book_store/helper/database_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends MaterialPageRoute {
  AddBookScreen()
      : super(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text("Add Book"),
            ),
            body: Body(),
          ),
        );
}

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();

  void insertData() async {
    if (bookNameController.text.isEmpty ||
        bookAuthorController.text.isEmpty ||
        bookPriceController.text.isEmpty) {
      alertDialog('Please Enter All Fields');
    } else {
      Book book = Book(
        bookName: bookNameController.text,
        bookAuthor: bookAuthorController.text,
        bookPrice: int.parse(bookPriceController.text),
      );
      DatabaseHelper databaseHelper = DatabaseHelper();
      int result = await databaseHelper.insertData(book);
      if (result == 0) {
        alertDialog('Error');
      } else {
        alertDialog('Success');
      }
    }
  }

  void alertDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: bookNameController,
            onSubmitted: ((value) => bookNameController.text = value),
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Book Name',
                hintText: 'Enter Book Name'),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: bookAuthorController,
            onSubmitted: ((value) => bookAuthorController.text = value),
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Book Author',
                hintText: 'Enter Book Author'),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: bookPriceController,
            onSubmitted: ((value) => bookPriceController.text = value),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Book Price',
                hintText: 'Enter Book Price'),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              insertData();
            },
            child: Text('Save'),
          ),
        )
      ],
    );
  }
}
