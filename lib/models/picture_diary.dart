import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Picture_Diary {
  int? id;
  String description;
  String taken_at;
  int user_id;
  String location;
  String image;
  String title;
  Picture_Diary({
    this.id,
    required this.image,
    required this.description,
    required this.taken_at,
    required this.user_id,
    required this.location,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'taken_at': taken_at,
      'user_id': user_id,
      'location': location,
    };
  }
}
