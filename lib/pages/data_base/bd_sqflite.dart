import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  static final dbHelper _instance = dbHelper._internal();
  factory dbHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  dbHelper._internal();

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'buscapets.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        primeiroNome TEXT,
        ultimoNome TEXT,
        email TEXT UNIQUE,
        senha TEXT
      )
    ''');
  }

  Future<int> salvarUsuario(Map<String, dynamic> usuario) async {
    var dbClient = await db;
    return await dbClient.insert('usuario', usuario);
  }

  Future<Map<String, dynamic>?> loginUsuario(String email, String senha) async {
    var dbClient = await db;

    List<Map<String, dynamic>> result = await dbClient.query(
      'usuario',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (result.isNotEmpty) {
      return Map<String, dynamic>.from(result.first);
    }

    return null;
  }
}
