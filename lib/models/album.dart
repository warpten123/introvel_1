import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Album {
  int? id;
  int user_id;
  String album_title;
  String created_at;
  String? path;
  int? diary_id;
  Album({
    this.id,
    required this.user_id,
    required this.album_title,
    required this.created_at,
    this.diary_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "user_id": user_id,
      'id': id,
      'album_title': album_title,
      'created_at': created_at,
      'diary_id': diary_id,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      user_id: map['user_id'] as int,
      id: map['id'] != null ? map['id'] as int : null,
      album_title: map['album_title'] as String,
      created_at: map['created_at'] as String,
      diary_id: map['diary_id'] != null ? map['diary_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) =>
      Album.fromMap(json.decode(source) as Map<String, dynamic>);
}
