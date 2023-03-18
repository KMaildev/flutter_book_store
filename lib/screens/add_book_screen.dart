import 'package:book_store/helper/database_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddBookScreen extends StatefulWidget {
  Book? book;
  AddBookScreen({this.book});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final ImagePicker picker = ImagePicker();
  String? path;

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();
  TextEditingController bookImageController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      bookNameController.text = widget.book!.bookName!;
      bookAuthorController.text = widget.book!.bookAuthor!;
      bookPriceController.text = widget.book!.bookPrice!.toString();
      bookImageController.text = widget.book!.bookImage!;
    }
  }

  void insertData() async {
    if (bookNameController.text.isEmpty ||
        bookAuthorController.text.isEmpty ||
        bookPriceController.text.isEmpty ||
        path == null) {
      alertDialog('Please Enter All Fields');
    } else {
      Book book = Book(
        bookName: bookNameController.text,
        bookAuthor: bookAuthorController.text,
        bookPrice: int.parse(bookPriceController.text),
        bookImage: path,
      );

      int result = 0;
      if (widget.book != null) {
        result = await databaseHelper.updateData(book, widget.book!.id!);
      } else {
        result = await databaseHelper.insertData(book);
      }

      if (result == 0) {
        alertDialog('Error');
      } else {
        alertDialog('Successful');
      }
    }
  }

  void deleteBook() async {
    alertDialog('Are you sure want to delete?');
    if (widget.book != null) {
      await databaseHelper.deleteData(widget.book!.id!);
    }
    Navigator.pop(context);
  }

  void alertDialog(String message) {
    showDialog(
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
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Book'),
        ),
        body: Column(
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
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  var img = await picker.pickImage(source: ImageSource.gallery);
                  path = img?.path;
                  setState(() {});
                },
                child: const Text("Choose Image"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        insertData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.book != null ? 'Update' : 'Save',
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
