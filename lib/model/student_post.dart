import 'dart:convert';

StudentPost studentPostFromJson(String str) =>
    StudentPost.fromJson(json.decode(str));

String studentPostToJson(StudentPost data) => json.encode(data.toJson());

class StudentPost {
  StudentPost({
    required this.data,
  });

  List<Datum> data;

  factory StudentPost.fromJson(Map<String, dynamic> json) => StudentPost(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  get id => null;
  get title => null;
  get description => null;

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.description,
    this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String description;
  dynamic createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
