import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:projeto_corretora/tabelas_sql.dart';

class Conexao {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        // On web, open and create if not exists
        _db = await databaseFactory.openDatabase('projeto_corretora_web.db');
        // Ensure tables are created if they don't exist
        for (final comando in criarTabelasWeb) {
          // Use a version for web with IF NOT EXISTS
          await _db!.execute(comando);
        }
      } else {
        final dbPath = await getDatabasesPath();
        final path = p.join(dbPath, 'projeto_corretora.db');

        // IMPORTANT: Removed deleteDatabase(path); for production
        // This line is ONLY for development to clear the database
        //await deleteDatabase(path); // <--- REMOVE THIS FOR PRODUCTION!

        _db = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            // This runs ONLY when the database is first created
            for (final comando in criarTabelas) {
              await db.execute(comando);
            }
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            // Handle database migrations here if you change the schema later
            // For example:
            // if (oldVersion < 2) {
            //   await db.execute('ALTER TABLE pessoa ADD COLUMN newColumn TEXT;');
            // }
          },
        );
      }
      return _db!;
    } catch (e, stack) {
      // In a real app, use a proper logging solution like package:logger
      print('Erro ao abrir o banco de dados: $e');
      print(stack);
      rethrow; // Re-throw to propagate the error up the call stack
    }
  }
}
