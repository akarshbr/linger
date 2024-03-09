import 'package:sqflite/sqflite.dart' as sql;

class SQLFunction {
  static Future<sql.Database> openOrCreateDB() async {
    return sql.openDatabase('users', version: 1, onCreate: (sql.Database db, int version) async {
      await createTable(db);
    });
  }

  static Future<void> createTable(sql.Database db) async {
    await db.execute(
        'CREATE TABLE userdata (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)');
  }

  static Future<int> addUser(String name, String email, String password) async {
    var db = await SQLFunction.openOrCreateDB();
    var data = {"name": name, "email": email, "password": password};
    var id = db.insert("userdata", data);
    return id;
  }

  static Future<List<Map>> checkUserExist(String email, String password) async {
    var db = await SQLFunction.openOrCreateDB();
    final data = await db
        .rawQuery("SELECT * FROM userdata WHERE email = '$email' AND password = '$password'");
    return data;
  }

  static Future<List<Map>> checkUserRegistered(String email) async {
    var db = await SQLFunction.openOrCreateDB();
    final user = await db.rawQuery("SELECT * FROM userdata WHERE email = '$email'");
    return user;
  }

  static Future<List<Map<String, dynamic>>> getALLUsers() async {
    var db = await SQLFunction.openOrCreateDB();
    final allUsers = db.rawQuery("SELECT * FROM userdata");
    return allUsers;
  }

  static Future<void> deleteUser(int id) async {
    var db = await SQLFunction.openOrCreateDB();
    db.delete("userdata", where: "id = ?", whereArgs: [id]);
  }
}
