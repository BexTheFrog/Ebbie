import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ebbie.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Usuários
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        senha TEXT NOT NULL,
        carteira INTEGER DEFAULT 0
      )
    ''');

    // Cortex
    await db.execute('''
      CREATE TABLE cortex(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idUsuario INTEGER,
        nome TEXT NOT NULL,
        fome REAL,
        fit REAL,
        higiene REAL,
        FOREIGN KEY(idUsuario) REFERENCES user(id)
      )
    ''');

    // Modulo
    await db.execute('''
      CREATE TABLE modulo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idUsuario INTEGER,
        nome TEXT NOT NULL,
        FOREIGN KEY(idUsuario) REFERENCES user(id)
      )
    ''');

    // Materia
    await db.execute('''
      CREATE TABLE materia(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idUsuario INTEGER,
        moduloId INTEGER,
        nome TEXT NOT NULL,
        FOREIGN KEY(moduloId) REFERENCES modulo(id),
        FOREIGN KEY(idUsuario) REFERENCES user(id)
      )
    ''');

    // Tarefa
    await db.execute('''
      CREATE TABLE tarefa(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idUsuario INTEGER,
        idModulo INTEGER,
        idMateria INTEGER,
        topico TEXT NOT NULL,
        dataRevisao TEXT,
        status TEXT,
        wasReviewd INTEGER DEFAULT 0,
        FOREIGN KEY(idModulo) REFERENCES modulo(id),
        FOREIGN KEY(idMateria) REFERENCES materia(id),
        FOREIGN KEY(idUsuario) REFERENCES user(id)
      )
    ''');

    // Estatisticas
    await db.execute('''
    CREATE TABLE review_stats(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario TEXT NOT NULL,
      idTarefa TEXT NOT NULL,
      status TEXT NOT NULL,
      data TEXT NOT NULL,
      FOREIGN KEY(idUsuario) REFERENCES usuarios(id) ON DELETE CASCADE,
      FOREIGN KEY(idTarefa) REFERENCES tarefas(id) ON DELETE CASCADE
    )
  ''');
  }

  // ---------------------- CRUD Genérico ----------------------

  // Inserir
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  // Atualizar
  Future<int> update(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  // Deletar
  Future<int> delete(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // Consultar
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }
}
