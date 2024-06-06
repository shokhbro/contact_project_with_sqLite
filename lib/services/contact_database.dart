import 'package:new_contact/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  ContactDatabase._singleton();

  static final ContactDatabase _contactDatabase = ContactDatabase._singleton();
  factory ContactDatabase() {
    return _contactDatabase;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/contact.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createContact,
    );
  }

  Future<void> _createContact(Database db, int version) async {
    await db.execute("""
      CREATE TABLE  contacts (
        id INTREMENT PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        surname TEXT NOT NULL,
        phoneNumber TEXT NOT NULL
      )
  """);
  }

  Future<void> addContact(Contact contact) async {
    final db = await database;
    await db.insert(
      "contacts",
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(int? id) async {
    final db = await database;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
