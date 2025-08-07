import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:projeto_corretora/tabelas_sql.dart';
import 'package:projeto_corretora/dados_bd.dart';

class Conexao {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        _db = await databaseFactory.openDatabase('projeto_corretora_web.db');
        for (final comando in criarTabelasWeb) {
          await _db!.execute(comando);
        }
      } else {
        final dbPath = await getDatabasesPath();
        final path = p.join(dbPath, 'projeto_corretora.db');

        await deleteDatabase(path); ///////////////////////////

        _db = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            for (final comando in criarTabelas) {
              await db.execute(comando);
            }
          },
          onUpgrade: (db, oldVersion, newVersion) async {},
        );
      }

      for (final sql in popularBancoDeDados) {
        await _db!.rawInsert(sql);
      }

      return _db!;
    } catch (e, stack) {
      print('Erro ao abrir o banco de dados: $e');
      print(stack);
      rethrow;
    }
  }
}
