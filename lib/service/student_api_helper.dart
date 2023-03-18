import 'dart:convert';
import 'dart:io';

import 'package:book_store/model/student_post.dart';
import 'package:dio/dio.dart';

class StudentApiHelper {
  final dio = Dio();

  Future<StudentPost> getStudentPost() async {
    final response = await dio.get('https://api.macrokennel.com/api/posts');
    return StudentPost.fromJson(response.data);
  }

  Future uploadPostData(String title, String description) async {
    final response = await dio.post(
      'https://api.macrokennel.com/api/posts',
      data: {
        'title': title,
        'description': description,
      },
    );
    return response.data;
  }

  Future deletePostData(int id) async {
    final response =
        await dio.delete('https://api.macrokennel.com/api/posts/$id');
    return response.data;
  }
}
