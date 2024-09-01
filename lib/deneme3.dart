import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper2 {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE sure(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'kindacode2.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String title, String? descrption) async {
    print("geliyor2");
    print(title);
    final db = await SQLHelper2.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('sure', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper2.db();
    return db.query('sure', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper2.db();
    return db.query('sure', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SQLHelper2.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('sure', data, where: "id = ?", whereArgs: [id]);
    return result;
  }


  // Delete
  static Future<void> deleteItem(title) async {
    final db = await SQLHelper2.db();
    try {
      print(title);
      await db.delete("sure", where: "title = ?", whereArgs: [title]);
      print("geldi1");
    } catch (err) {
      print("geldi2");
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}