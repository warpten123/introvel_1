import 'package:intl/intl.dart';
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

  static Future<sql.Database> db() async {
    return sql.openDatabase('introvel.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTableUser(database);
      await createTableImages(database);
      await createTablePictureDiary(database);
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
}
