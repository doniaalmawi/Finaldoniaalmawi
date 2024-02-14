import 'package:logandprice/json/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'comp .db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "pricestb" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "price" TEXT NOT NULL,
    "weightt" TEXT NOT  NULL
  )
 ''');
    print(" onCreate =====================================");
    await db.execute('''
  CREATE TABLE "orderstb" (
    "idorder" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "codeorder" TEXT NOT NULL,
    "stateorder" TEXT NOT  NULL
  )
 ''');
    print(" onCreate =====================================");
    await db.execute('''
  CREATE TABLE "users" (
    "usrId" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "usrName" TEXT NOT NULL,
    "usrPassword" TEXT NOT  NULL,
        "userType" TEXT NOT  NULL

  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

// delete database
  mydeletetabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'comp .db');
    await deleteDatabase(path);
  }

  Future<int> signup(Users user) async {
    final Database db = await intialDb();

    return db.insert('users', user.toMap());
  }

  Future<bool> login(Users user) async {
    final Database db = await intialDb();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}' AND userType = '${user.userType}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
// SELECT
// DELETE
// UPDATE
// INSERT
}
