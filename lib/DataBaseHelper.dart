import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';





class DataBaseHelper{

  static final _databasename = "mydatabase";
  static final _databaseversion = 1;
  static final table ="mytable";
  static final columnid = '_id';
  static final columnname = 'name';

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

 static Database _database;

 Future<Database> get database async{
   if(_database == null){

   }
   _database = _initDatabase();
   return _database;
 }


  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databasename);

    return await openDatabase(path,
        version: _databaseversion,
        onCreate: _onCreate);
  }





  FutureOr<void> _onCreate(Database db, int version) async {
   await db.execute(" CREATE TABLE $table  (  $columnid  INTEGER PRIMARY KEY,  $columnname  TEXT NOT NULL )" );

//    await db.execute('''
//          CREATE TABLE $table (
//            $columnid INTEGER PRIMARY KEY,
//            $columnname TEXT NOT NULL,
//          )
//          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance._initDatabase();
    int id =  await db.insert(table, row);
    return id;
 }

   Future<List<Map<String,dynamic>>> queryAllRows() async {
    Database db = await instance._initDatabase();
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT * FROM $table');
    x.forEach((row)=> print(row.values));
    return x;
 }
}


