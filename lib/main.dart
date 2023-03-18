import 'package:book_store/screens/add_book_screen.dart';
import 'package:book_store/screens/exchange_rate_screen.dart';
import 'package:book_store/screens/image_upload.dart';
import 'package:book_store/screens/my_painter.dart';
import 'package:book_store/screens/post_screen.dart';
import 'package:book_store/screens/student_post_screen.dart';
import 'package:flutter/material.dart';

import 'helper/database_helper.dart';
import 'model/book.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Book Store'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Admin',
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                'admin@gmail.com',
                style: TextStyle(fontSize: 18),
              ),
              currentAccountPicture:
                  CircleAvatar(backgroundColor: Colors.black),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBookScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Add Book",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUpload(),
                    ),
                  );
                },
                child: const Text(
                  "Upload Image",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPainter(),
                    ),
                  );
                },
                child: const Text(
                  "Painter",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExchangeRateScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Exchange",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Post",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentPostScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Student Post",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: databaseHelper.getAllData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const CircularProgressIndicator()
            : GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.file(
                            File(snapshot.data![index].bookImage!),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data![index].bookName!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].bookPrice.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              snapshot.data![index].bookAuthor!,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
