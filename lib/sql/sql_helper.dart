import 'package:intl/intl.dart';
import 'package:introvel_1/models/album.dart';
import 'package:introvel_1/models/picture_diary.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class SQLHelper {
  static Future<void> createTableUser(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        email TEXT,
        password TEXT,
        profile_image INTEGER
      )
""");
  }

  static Future<void> createTableImages(sql.Database database) async {
    await database.execute("""
      CREATE TABLE images(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        profile_image TEXT
      )
""");
  }

  static Future<void> createTablePictureDiary(sql.Database database) async {
    await database.execute("""
      CREATE TABLE picture_diary(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT,
        description TEXT,
        taken_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER,
        location TEXT,
        title TEXT
      )
""");
  }

  static Future<void> createAlbum(sql.Database database) async {
    await database.execute("""
      CREATE TABLE album(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        album_title TEXT,
        user_id INTEGER,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
""");
  }

  static Future<void> createAlbumWithDiaries(sql.Database database) async {
    await database.execute("""
      CREATE TABLE album_diaries(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user_id INTEGER,
        diary_id INTEGER
      )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('introvel.db', version: 2,
        onCreate: (sql.Database database, int version) async {
      await createTableUser(database);
      await createTableImages(database);
      await createTablePictureDiary(database);
      await createAlbum(database);
    }, onUpgrade:
            (sql.Database database, int oldVersion, int newVersion) async {
      if (oldVersion < 2) {
        await createAlbumWithDiaries(database);
      }
    });
  }

  // static Future<sql.Database> dbforDiary() async {
  //   return sql.openDatabase('introvel.db', version: 1,
  //       onCreate: (sql.Database database, int version) async {
  //     await createTablePictureDiary(database);
  //   });
  // }

  static Future<int> registerUser(
      String email, String? password, String? path) async {
    final db = await SQLHelper
        .db(); //create db if db not exist and create table if not exist also.

    final data = {
      'email': email,
      'password': password,
      'profile_image': path,
    }; //anon object, but i need a class
    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); //obvious shit
    return id;
  }

  static Future<int> storeProfileImage(String imagePath) async {
    final db = await SQLHelper
        .db(); //create db if db not exist and create table if not exist also.
    final data = {
      'profile_image': imagePath,
    };
    // final data = {
    //   'title': title,
    //   'description': description
    // }; //anon object, but i need a class
    final id = await db.insert('images', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); //obvious shit
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProfileImages() async {
    final db = await SQLHelper.db();
    return db.query('images',
        orderBy: "id"); // query for fetching, updating, deleting
  }

  static Future<List<Map<String, dynamic>>> getSingleUser(String email) async {
    // if therer is a model class, it shouldnt be list<map<>>, just  call the model name for better code readabality and scaling
    // but anyway, im stupid so idk.
    final db = await SQLHelper.db();
    final res = await db.query('user',
        where: "email = ?", whereArgs: [email], limit: 1);

    return res; //just get one item using the ID
  }

  static Future<int> storePictureDiary(String imagePath, String description,
      int user_id, String location, String title) async {
    final db = await SQLHelper
        .db(); //create db if db not exist and create table if not exist also.
    final data = {
      'image': imagePath,
      'description': description,
      'taken_at': DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      'user_id': user_id,
      'location': location,
      'title': title,
    };
    // final data = {
    //   'title': title,
    //   'description': description
    // }; //anon object, but i need a class
    final id = await db.insert('picture_diary', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); //obvious shit
    return id;
  }

  static Future<List<Map<String, dynamic>>> getProfileDiariesUser(
      int user_id) async {
    // if therer is a model class, it shouldnt be list<map<>>, just  call the model name for better code readabality and scaling
    // but anyway, im stupid so idk.
    final db = await SQLHelper.db();
    final res = await db
        .query('picture_diary', where: "user_id = ?", whereArgs: [user_id]);

    return res;
  }

  static Future<List<Map<String, dynamic>>> getProfileDiaryUser(
      int diary_id) async {
    // if therer is a model class, it shouldnt be list<map<>>, just  call the model name for better code readabality and scaling
    // but anyway, im stupid so idk.
    final db = await SQLHelper.db();
    final res = await db.query('picture_diary',
        where: "id = ?", whereArgs: [diary_id], limit: 1);

    return res; //just get one item using the ID
  }

  static Future<int> createAlbumPictureDiary(
      int user_id, String album_text) async {
    final db = await SQLHelper
        .db(); //create db if db not exist and create table if not exist also.
    final data = {
      'created_at': DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
      'user_id': user_id,
      'album_title': album_text,
    };

    final id = await db.insert('album', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); //obvious shit
    print("CREATED: $id");
    return id;
  }

  static Future<List<Album>> getAlbumsUser(int user_id) async {
    final db = await SQLHelper.db();
    final res = await db.query(
      'album',
      where: "user_id = ?",
      whereArgs: [user_id],
    );
    print("res $res");
    List<Album> albums =
        res.map((albumMap) => Album.fromMap(albumMap)).toList();
    albums.forEach((album) {
      print(album.album_title);
    });
    return albums;
  }

  static Future<List<Map<String, dynamic>>> getAllAlbums() async {
    final db = await SQLHelper.db();
    final test = db.query('album', orderBy: "id");
    return test; // query for fetching, updating, deleting
  }

  static Future<int> storeDiaryInAlbum(
      int user_id, int diary_id, int album_id) async {
    final db = await SQLHelper
        .db(); //create db if db not exist and create table if not exist also.
    final data = {
      'album_id': album_id,
      'user_id': user_id,
      'diary_id': diary_id,
    };

    final id = await db.insert('album_diaries', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace); //obvious shit
    print("CREATED: $id");
    return id;
  }

  static Future<List<Map<String, dynamic>>> fetchDiariesInAlbum(
      int album_id) async {
    final db = await SQLHelper.db();

    final result = await db.rawQuery('''
    SELECT picture_diary.* 
    FROM picture_diary 
    INNER JOIN album_diaries ON picture_diary.id = album_diaries.diary_id 
    WHERE album_diaries.album_id = ?
  ''', [album_id]);

    return result;
  }
}
