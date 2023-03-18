import 'package:book_store/model/student_post.dart';
import 'package:book_store/screens/add_student_post_screen.dart';
import 'package:book_store/service/student_api_helper.dart';
import 'package:flutter/material.dart';

class StudentPostScreen extends StatefulWidget {
  const StudentPostScreen({super.key});

  @override
  State<StudentPostScreen> createState() => _StudentPostScreenState();
}

class _StudentPostScreenState extends State<StudentPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  StudentApiHelper studentApiHelper = StudentApiHelper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentPostScreen(),
                ),
              );
            },
            child: const Text("Upload Post"),
          ),
          StudentPostList(studentApiHelper: studentApiHelper),
        ],
      ),
    );
  }
}

class StudentPostList extends StatefulWidget {
  const StudentPostList({
    Key? key,
    required this.studentApiHelper,
  }) : super(key: key);

  final StudentApiHelper studentApiHelper;

  @override
  State<StudentPostList> createState() => _StudentPostListState();
}

class _StudentPostListState extends State<StudentPostList> {
  void deletePost(int id) {
    setState(() {});
    widget.studentApiHelper.deletePostData(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentPost>(
      future: widget.studentApiHelper.getStudentPost(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: Text('Loading...'))
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 3),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(8.0),
                              color: Colors.amberAccent,
                              child: Text(snapshot.data!.data[index].title),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.data[index].description,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    deletePost(snapshot.data!.data[index].id);
                                  },
                                  child: const Text("Delete"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddStudentPostScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("Edit"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
