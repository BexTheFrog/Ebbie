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

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );

    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL,
      senha TEXT NOT NULL,
      carteira INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
    CREATE TABLE cortex(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario INTEGER,
      nome TEXT NOT NULL,
      fome REAL,
      fit REAL,
      higiene REAL,
      FOREIGN KEY(idUsuario) REFERENCES user(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE modulo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario INTEGER,
      nome TEXT NOT NULL,
      descricao TEXT NOT NULL,
      FOREIGN KEY(idUsuario) REFERENCES user(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE materia(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario INTEGER,
      moduloId INTEGER,
      nome TEXT NOT NULL,
      FOREIGN KEY(moduloId) REFERENCES modulo(id) ON DELETE CASCADE,
      FOREIGN KEY(idUsuario) REFERENCES user(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE tarefa(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario INTEGER,
      idModulo INTEGER,
      idMateria INTEGER,
      topico TEXT NOT NULL,
      dataRevisao TEXT,
      descricao TEXT,
      status TEXT,
      wasReviewd INTEGER DEFAULT 0,
      FOREIGN KEY(idModulo) REFERENCES modulo(id) ON DELETE CASCADE,
      FOREIGN KEY(idMateria) REFERENCES materia(id) ON DELETE CASCADE,
      FOREIGN KEY(idUsuario) REFERENCES user(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE review_stats(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idUsuario INTEGER NOT NULL,
      idTarefa INTEGER NOT NULL,
      status TEXT NOT NULL,
      data TEXT NOT NULL,
      FOREIGN KEY(idUsuario) REFERENCES user(id) ON DELETE CASCADE,
      FOREIGN KEY(idTarefa) REFERENCES tarefa(id) ON DELETE CASCADE
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

  // ------------ Buscar estatisticas do perfil --------

  Future<Map<String, int>> getUserStats(int userId) async {
    final db = await database;

    // Contar revisões realizadas
    final realizado =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM review_stats WHERE idUsuario = ? AND status = ?',
            [userId, 'realizado'],
          ),
        ) ??
        0;

    // Contar revisões puladas
    final pulou =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(*) FROM review_stats WHERE idUsuario = ? AND status = ?',
            [userId, 'pulou'],
          ),
        ) ??
        0;

    // Contar tópicos memorizados
    final memorizou =
        Sqflite.firstIntValue(
          await db.rawQuery(
            'SELECT COUNT(DISTINCT idTarefa) FROM review_stats WHERE idUsuario = ? AND status = ?',
            [userId, 'memorizou'],
          ),
        ) ??
        0;

    return {'realizou': realizado, 'pulou': pulou, 'memorizou': memorizou};
  }
}
