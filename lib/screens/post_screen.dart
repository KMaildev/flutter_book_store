import 'package:book_store/model/post.dart';
import 'package:book_store/service/api_helper.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: ApiHelper.getAllPost(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      ApiHelper.postData(
                        Post(userId: 1, id: 1, title: 'title', body: 'body'),
                      );
                    },
                    child: Column(
                      children: [
                        Text("${snapshot.data![index].userId}"),
                        Text("${snapshot.data![index].id}"),
                        Text(snapshot.data![index].title),
                        Text(snapshot.data![index].body),
                        const ElevatedButton(
                          onPressed: null,
                          child: Text('Detail'),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
