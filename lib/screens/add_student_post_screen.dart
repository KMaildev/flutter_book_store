// ignore_for_file: must_be_immutable
import 'package:book_store/service/student_api_helper.dart';
import 'package:flutter/material.dart';

class AddStudentPostScreen extends StatefulWidget {
  AddStudentPostScreen({super.key});

  @override
  State<AddStudentPostScreen> createState() => _AddStudentPostScreenState();
}

class _AddStudentPostScreenState extends State<AddStudentPostScreen> {
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();

  void postInertData(String title, String description) {
    setState(() {});
    StudentApiHelper studentApiHelper = StudentApiHelper();
    if (title.isEmpty || description.isEmpty) {
      alertDialog('Please Enter All Fields');
    } else {
      studentApiHelper.uploadPostData(title, description);
      Navigator.pop(context);
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text(
                'Upload your post',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: postTitleController,
              onSubmitted: ((value) => postTitleController.text = value),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Post Title',
                  hintText: 'Enter Post Title'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: postDescriptionController,
              onSubmitted: ((value) => postDescriptionController.text = value),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Post Description',
                  hintText: 'Enter Post Description'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              postInertData(
                  postTitleController.text, postDescriptionController.text);
            },
            child: const Text("Upload Now"),
          ),
        ],
      ),
    );
  }
}
