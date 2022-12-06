import 'package:m_hike_flutter/helper/hike_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = "mHike.db";
  static const _databaseNameImg = "mHikeImg.db";
  static const _databaseVersion = 1;
  static const _databaseVersionImg = 1;

  static const table = 'hike_table';
  static const table_img = 'hike_table_img';

  static const columnIdImg = 'id';
  static const columnHikeIdImg = 'hikeId';
  static const columnImgUrl = 'imageUrl';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnLocation = 'location';
  static const columnDate = 'date';
  static const columnParking = 'parking';
  static const columnLength = 'length';
  static const columnDifficulty = 'difficulty';
  static const columnAccommodation = 'accommodation';
  static const columnPersonLimit = 'personLimit';
  static const columnDescription = 'description';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnLocation Text NOT NULL,
            $columnDate Text NOT NULL,
            $columnParking Text NOT NULL,
            $columnLength Text NOT NULL,
            $columnDifficulty Text NOT NULL,
            $columnAccommodation Text NOT NULL,
            $columnPersonLimit Text NOT NULL,
            $columnDescription Text NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_img (
            $columnIdImg INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnHikeIdImg INTEGER NOT NULL,
            $columnImgUrl Text NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(data) async {
    Database? db = await instance.database;
    return await db!.insert(table, data);
  }

  Future<int> insertImg(data) async {
    Database? db = await instance.database;
    return await db!.insert(table_img, data);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllImg() async {
    Database? db = await instance.database;
    return await db!.query(table_img);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(id) async {
    Database? db = await instance.database;
    return await db!.query(table, where: "$columnName LIKE '%$id%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(car) async {
    Database? db = await instance.database;
    int id = car['id'];
    return await db!.update(table, car, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int? id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}