// lib/services/database_service.dart
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'entity/entity.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _db;
  Future<Database> get db async => _db ??= await _initDB();

  static const _dbName = "app_database.db";
  static const _dbVersion = 1;

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onConfigure: (db) async {
        // включаем foreign keys
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    // Создание таблиц (адаптация под SQLite)
    await db.execute('''
      CREATE TABLE EI (
        ID_EI INTEGER PRIMARY KEY AUTOINCREMENT,
        CODE TEXT,
        SHORT_NAME TEXT,
        NAME TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE TYPE_STATE (
        ID_STATE INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        SH_NAME TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE TYPE_DECISION (
        ID_DEC INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        SH_NAME TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE CHEM_CLASS (
        ID_CLASS INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        SHORT_NAME TEXT,
        BASE_EI INTEGER,
        MAIN_CLASS INTEGER,
        FOREIGN KEY (BASE_EI) REFERENCES EI(ID_EI),
        FOREIGN KEY (MAIN_CLASS) REFERENCES CHEM_CLASS(ID_CLASS)
      );
    ''');

    await db.execute('''
      CREATE TABLE GR_PERSON (
        ID_GR INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE PERSON (
        ID_PER INTEGER PRIMARY KEY AUTOINCREMENT,
        FIO TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE CONSIST_GR (
        ID_GR INTEGER NOT NULL,
        ID_PER INTEGER NOT NULL,
        PRIMARY KEY (ID_GR, ID_PER),
        FOREIGN KEY (ID_GR) REFERENCES GR_PERSON(ID_GR),
        FOREIGN KEY (ID_PER) REFERENCES PERSON(ID_PER)
      );
    ''');

    await db.execute('''
      CREATE TABLE TYPE_PROCESS (
        ID_TYPE_PROC INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        SH_NAME TEXT,
        ID_CLASS INTEGER NOT NULL,
        FOREIGN KEY (ID_CLASS) REFERENCES CHEM_CLASS(ID_CLASS)
      );
    ''');

    await db.execute('''
      CREATE TABLE STATE (
        ID_TYPE_PR INTEGER NOT NULL,
        ID_STATE INTEGER NOT NULL,
        FLAG_BEG INTEGER NOT NULL,
        PRIMARY KEY (ID_TYPE_PR, ID_STATE),
        FOREIGN KEY (ID_TYPE_PR) REFERENCES TYPE_PROCESS(ID_TYPE_PROC),
        FOREIGN KEY (ID_STATE) REFERENCES TYPE_STATE(ID_STATE)
      );
    ''');

    await db.execute('''
      CREATE TABLE DECISION (
        ID_TYPE_PR INTEGER NOT NULL,
        ID_STATE INTEGER NOT NULL,
        ID_DEC INTEGER NOT NULL,
        PRIMARY KEY (ID_TYPE_PR, ID_STATE, ID_DEC),
        FOREIGN KEY (ID_DEC) REFERENCES TYPE_DECISION(ID_DEC),
        FOREIGN KEY (ID_TYPE_PR, ID_STATE) REFERENCES STATE(ID_TYPE_PR, ID_STATE)
      );
    ''');

    await db.execute('''
      CREATE TABLE ACCESS_STATE (
        ID_TYPE_PR INTEGER NOT NULL,
        ID_GR INTEGER NOT NULL,
        ID_STATE INTEGER NOT NULL,
        PRIMARY KEY (ID_TYPE_PR, ID_GR, ID_STATE),
        FOREIGN KEY (ID_GR) REFERENCES GR_PERSON(ID_GR),
        FOREIGN KEY (ID_TYPE_PR, ID_STATE) REFERENCES STATE(ID_TYPE_PR, ID_STATE)
      );
    ''');

    await db.execute('''
      CREATE TABLE PREDICAT (
        ID_PRED INTEGER PRIMARY KEY AUTOINCREMENT,
        ID_STATE INTEGER NOT NULL,
        ID_DEC INTEGER NOT NULL,
        YES_PAR INTEGER,
        FOREIGN KEY (ID_STATE) REFERENCES TYPE_STATE(ID_STATE),
        FOREIGN KEY (ID_DEC) REFERENCES TYPE_DECISION(ID_DEC)
      );
    ''');

    await db.execute('''
      CREATE TABLE FORMULA (
        ID_F INTEGER NOT NULL,
        NUM_DIS INTEGER NOT NULL,
        ID_PRED INTEGER NOT NULL,
        NUM_CON INTEGER NOT NULL,
        PRIMARY KEY (ID_F, NUM_DIS, NUM_CON),
        FOREIGN KEY (ID_PRED) REFERENCES PREDICAT(ID_PRED)
      );
    ''');

    await db.execute('''
      CREATE TABLE PROCESS (
        ID_PROCESS INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME TEXT,
        SH_NAME TEXT,
        TYPE_PR INTEGER,
        ID_CLASS INTEGER,
        FOREIGN KEY (TYPE_PR) REFERENCES TYPE_PROCESS(ID_TYPE_PROC),
        FOREIGN KEY (ID_CLASS) REFERENCES CHEM_CLASS(ID_CLASS)
      );
    ''');

    await db.execute('''
      CREATE TABLE TRAJECTORY (
        ID_PROCESS INTEGER NOT NULL,
        NUM_POS INTEGER NOT NULL,
        ID_STATE INTEGER NOT NULL,
        ID_DEC INTEGER NOT NULL,
        ID_PER INTEGER NOT NULL,
        D_TIME TEXT DEFAULT (datetime('now')),
        PRIMARY KEY (ID_PROCESS, NUM_POS),
        FOREIGN KEY (ID_PROCESS) REFERENCES PROCESS(ID_PROCESS),
        FOREIGN KEY (ID_STATE) REFERENCES TYPE_STATE(ID_STATE),
        FOREIGN KEY (ID_DEC) REFERENCES TYPE_DECISION(ID_DEC),
        FOREIGN KEY (ID_PER) REFERENCES PERSON(ID_PER)
      );
    ''');
  }

  Future close() async {
    final database = await db;
    await database.close();
    _db = null;
  }

  // ----------------------------
  // seedData: добавляет стартовые записи если таблицы пусты
  // ----------------------------
  Future<void> seedData() async {
    final database = await db;

    await database.transaction((txn) async {
      // helper: check if table empty
      Future<bool> isEmpty(String table) async {
        final res = Sqflite.firstIntValue(
            await txn.rawQuery('SELECT COUNT(1) FROM $table'));
        return (res ?? 0) == 0;
      }

      // EI
      if (await isEmpty('EI')) {
        await txn.insert('EI',
            {'ID_EI': 1, 'CODE': 'PCS', 'SHORT_NAME': 'шт', 'NAME': 'Штуки'});
        await txn.insert('EI', {
          'ID_EI': 2,
          'CODE': 'KG',
          'SHORT_NAME': 'кг',
          'NAME': 'Килограммы'
        });
        await txn.insert('EI', {
          'ID_EI': 3,
          'CODE': 'SET',
          'SHORT_NAME': 'компл',
          'NAME': 'Комплект'
        });
      }

      // TYPE_DECISION: insert only if empty
      if (await isEmpty('TYPE_DECISION')) {
        final decisions = [
          ['Замечания КБ', 'KB!'],
          ['Согласовано в КБ', 'KB+'],
          ['Замечания ТО', 'TO!'],
          ['Согласовано в ТО', 'TO+'],
          ['Продукция не производится', 'NP'],
          ['Поставщик найден', 'FND'],
          ['Отказ поставщика', 'REJ'],
          ['Согласовано с поставщиком', 'OKP'],
          ['Замечания руководства', 'RH!'],
          ['Разрешено использовать', 'USE'],
          ['Запрет на использование', 'BAN'],
          ['Подтверждение запрета', 'CBAN'],
          ['Подтверждение разрешения', 'CUSE'],
          ['Отправлено на доработку', 'REDO'],
          ['Переотправлено ТО', 'RETO'],
          ['Завершить процесс', 'END'],
        ];
        for (var d in decisions) {
          await txn.insert('TYPE_DECISION', {'NAME': d[0], 'SH_NAME': d[1]});
        }
      }

      // TYPE_STATE
      if (await isEmpty('TYPE_STATE')) {
        final states = [
          ['Объявление нового комплектующего', '01'],
          ['Редактирование параметров', '02'],
          ['Согласование в КБ', '03'],
          ['Согласование ТО', '04'],
          ['Определение возможных поставщиков', '05'],
          ['Выставление требований поставщику', '06'],
          ['Разрешение на использование', '07'],
          ['Запрещено использовать', '08'],
        ];
        for (var s in states) {
          await txn.insert('TYPE_STATE', {'NAME': s[0], 'SH_NAME': s[1]});
        }
      }

      // GR_PERSON
      if (await isEmpty('GR_PERSON')) {
        final groups = [
          'Конструкторы',
          'Технологи',
          'Поставщики',
          'Руководство'
        ];
        for (var g in groups) {
          await txn.insert('GR_PERSON', {'NAME': g});
        }
      }

      // PERSON
      if (await isEmpty('PERSON')) {
        final people = [
          'Будило Е.А.',
          'Костенко И.А.',
          'Зашляхтин А.А.',
          'Михайлов М.М.'
        ];
        for (var p in people) {
          await txn.insert('PERSON', {'FIO': p});
        }
      }

      // CONSIST_GR
      if (await isEmpty('CONSIST_GR')) {
        // note: IDs correspond to inserted rows (auto increment starts from 1)
        await txn.insert('CONSIST_GR', {'ID_GR': 1, 'ID_PER': 1});
        await txn.insert('CONSIST_GR', {'ID_GR': 1, 'ID_PER': 2});
        await txn.insert('CONSIST_GR', {'ID_GR': 2, 'ID_PER': 3});
        await txn.insert('CONSIST_GR', {'ID_GR': 4, 'ID_PER': 4});
      }

      // CHEM_CLASS
      if (await isEmpty('CHEM_CLASS')) {
        await txn.insert('CHEM_CLASS', {
          'ID_CLASS': 1,
          'NAME': 'Комплектующее изделие',
          'SHORT_NAME': 'CMP',
          'BASE_EI': 1,
          'MAIN_CLASS': null
        });
      }

      // TYPE_PROCESS
      if (await isEmpty('TYPE_PROCESS')) {
        await txn.insert('TYPE_PROCESS', {
          'NAME': 'Включение нового комплектующего',
          'SH_NAME': 'NEWCMP',
          'ID_CLASS': 1
        });
      }

      // STATE (для TYPE_PR = 1) — добавляем записи 1..8
      if (await isEmpty('STATE')) {
        // assuming TYPE_PROCESS with id 1 exists
        for (var idState = 1; idState <= 8; idState++) {
          final flagBeg = (idState == 1) ? 1 : 0;
          await txn.insert('STATE', {
            'ID_TYPE_PR': 1,
            'ID_STATE': idState,
            'FLAG_BEG': flagBeg,
          });
        }
      }

      // DECISION (добавляем разрешённые переходы)
      if (await isEmpty('DECISION')) {
        final decisions = [
          [1, 1, 4],
          [1, 2, 4],
          [1, 3, 5],
          [1, 3, 8],
          [1, 4, 6],
          [1, 4, 9],
          [1, 5, 7],
          [1, 5, 10],
          [1, 6, 11],
          [1, 6, 12],
          [1, 7, 16],
          [1, 7, 14],
          [1, 8, 15],
          [1, 8, 13],
        ];
        for (var d in decisions) {
          await txn.insert('DECISION', {
            'ID_TYPE_PR': d[0],
            'ID_STATE': d[1],
            'ID_DEC': d[2],
          });
        }
      }

      // ACCESS_STATE
      if (await isEmpty('ACCESS_STATE')) {
        final access = [
          [1, 1, 1],
          [1, 2, 1],
          [1, 3, 1],
          [1, 3, 3],
          [1, 4, 2],
          [1, 5, 4],
          [1, 6, 4],
          [1, 7, 4],
          [1, 8, 4],
        ];
        for (var a in access) {
          await txn.insert('ACCESS_STATE', {
            'ID_TYPE_PR': a[0],
            'ID_GR': a[
                2], // note: original order in pg was (pIdTypePr, pIdState, pIdGr) but insertion here follows the intended mapping
            'ID_STATE': a[1],
          });
        }
      }

      // PREDICAT (упрощённо)
      if (await isEmpty('PREDICAT')) {
        final preds = [
          [1, 4, 1],
          [2, 4, 2],
          [3, 5, 3],
          [3, 8, 4],
          [4, 6, 5],
          [4, 9, 6],
          [5, 7, 7],
          [6, 10, 8],
          [7, 16, 9],
          [8, 15, 10],
        ];
        for (var p in preds) {
          await txn.insert('PREDICAT', {
            'ID_STATE': p[0],
            'ID_DEC': p[1],
            'YES_PAR': p[2],
          });
        }
      }

      // PROCESS
      if (await isEmpty('PROCESS')) {
        await txn.insert('PROCESS', {
          'NAME': 'Процесс включения нового комплектующего',
          'SH_NAME': 'PR_NEW_CMP',
          'TYPE_PR': 1,
          'ID_CLASS': 1
        });
      }

      // TRAJECTORY — запишем несколько шагов как в скрипте (через writeDec2 реализацию)
      final trajCount = Sqflite.firstIntValue(
              await txn.rawQuery('SELECT COUNT(1) FROM TRAJECTORY')) ??
          0;
      if (trajCount == 0) {
        // Приводим к поведению WRITE_DEC2 (валидация)
        Future<void> _writeDec2(
            int pIdProcess, int pIdState, int pIdDec, int pIdPer) async {
          // Получаем тип процесса
          final rows = await txn.query('PROCESS',
              columns: ['TYPE_PR'],
              where: 'ID_PROCESS = ?',
              whereArgs: [pIdProcess]);
          if (rows.isEmpty) {
            throw Exception('Процесс $pIdProcess не найден');
          }
          final vTypePr = rows.first['TYPE_PR'] as int?;

          // проверяем допустимость решения
          final valid = Sqflite.firstIntValue(await txn.rawQuery(
                  'SELECT COUNT(1) FROM DECISION WHERE ID_TYPE_PR = ? AND ID_STATE = ? AND ID_DEC = ?',
                  [vTypePr, pIdState, pIdDec])) ??
              0;
          if (valid == 0) {
            // невалидное решение — пропускаем или кидаем ошибку; здесь — кидаем
            throw Exception(
                'Недопустимое решение $pIdDec для состояния $pIdState');
          }

          // max pos
          final maxPos = Sqflite.firstIntValue(await txn.rawQuery(
                  'SELECT COALESCE(MAX(NUM_POS), 0) FROM TRAJECTORY WHERE ID_PROCESS = ?',
                  [pIdProcess])) ??
              0;

          await txn.insert('TRAJECTORY', {
            'ID_PROCESS': pIdProcess,
            'NUM_POS': maxPos + 1,
            'ID_STATE': pIdState,
            'ID_DEC': pIdDec,
            'ID_PER': pIdPer,
            'D_TIME': DateTime.now().toIso8601String(),
          });
        }

        // Выполняем шаги (как в оригинале)
        try {
          await _writeDec2(1, 1, 4, 1); // Шаг 1
          await _writeDec2(1, 3, 5, 2); // КБ: Конструктор
          await _writeDec2(1, 3, 5, 2); // КБ: повтор
          await _writeDec2(1, 4, 6, 3); // ТО
        } catch (e) {
          // если что-то не так (напр. отсутствуют внешние зависимости), просто логируем (или пробрасываем)
          // print('seedData: error writing trajectory: $e');
        }
      }
    });
  }


    // Вспомогательный метод: WRITE_DEC2 (аналог функции)
  Future<void> writeDec2({
    required int pIdProcess,
    required int pIdState,
    required int pIdDec,
    required int pIdPer,
  }) async {
    final database = await db;
    await database.transaction((txn) async {
      // Получаем TYPE_PR из PROCESS
      final rows = await txn.query('PROCESS',
          columns: ['TYPE_PR'],
          where: 'ID_PROCESS = ?',
          whereArgs: [pIdProcess]);
      if (rows.isEmpty) throw Exception('Процесс $pIdProcess не найден');
      final vTypePr = rows.first['TYPE_PR'] as int?;

      // проверка наличия допустимого решения
      final valid = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COUNT(1) FROM DECISION WHERE ID_TYPE_PR = ? AND ID_STATE = ? AND ID_DEC = ?',
              [vTypePr, pIdState, pIdDec])) ??
          0;
      if (valid == 0)
        throw Exception('Недопустимое решение $pIdDec для состояния $pIdState');

      // max NUM_POS
      final maxPos = Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COALESCE(MAX(NUM_POS), 0) FROM TRAJECTORY WHERE ID_PROCESS = ?',
              [pIdProcess])) ??
          0;

      await txn.insert('TRAJECTORY', {
        'ID_PROCESS': pIdProcess,
        'NUM_POS': maxPos + 1,
        'ID_STATE': pIdState,
        'ID_DEC': pIdDec,
        'ID_PER': pIdPer,
        'D_TIME': DateTime.now().toIso8601String(),
      });
    });
  }

  // ----------------------------
  // Методы чтения таблиц (возвращают List<Map<String, dynamic>>)
  // ----------------------------
  Future<List<EI>> getEi() async {
    final database = await db;
    final result = await database.query('EI', orderBy: 'ID_EI');
    return result.map((e) => EI.fromJson(e)).toList();
  }

  Future<List<TypeDecision>> getTypeDecision() async {
    final database = await db;
    final result = await database.query('TYPE_DECISION', orderBy: 'ID_DEC');
    return result.map((e) => TypeDecision.fromJson(e)).toList();
  }

  Future<List<TypeState>> getTypeState() async {
    final database = await db;
    final result = await database.query('TYPE_STATE', orderBy: 'ID_STATE');
    return result.map((e) => TypeState.fromJson(e)).toList();
  }

  Future<List<ChemClass>> getChemClass() async {
    final database = await db;
    final result = await database.query('CHEM_CLASS', orderBy: 'ID_CLASS');
    return result.map((e) => ChemClass.fromJson(e)).toList();
  }

  Future<List<GroupPerson>> getGrPerson() async {
    final database = await db;
    final result = await database.query('GR_PERSON', orderBy: 'ID_GR');
    return result.map((e) => GroupPerson.fromJson(e)).toList();
  }

  Future<List<Person>> getPerson() async {
    final database = await db;
    final result = await database.query('PERSON', orderBy: 'ID_PER');
    return result.map((e) => Person.fromJson(e)).toList();
  }

  Future<List<ConsistGroup>> getConsistGr() async {
    final database = await db;
    final result = await database.query('CONSIST_GR', orderBy: 'ID_GR, ID_PER');
    return result.map((e) => ConsistGroup.fromJson(e)).toList();
  }

  Future<List<TypeProcess>> getTypeProcess() async {
    final database = await db;
    final result =
        await database.query('TYPE_PROCESS', orderBy: 'ID_TYPE_PROC');
    return result.map((e) => TypeProcess.fromJson(e)).toList();
  }

  Future<List<StateEntity>> getState() async {
    final database = await db;
    final result =
        await database.query('STATE', orderBy: 'ID_TYPE_PR, ID_STATE');
    return result.map((e) => StateEntity.fromJson(e)).toList();
  }

  Future<List<Decision>> getDecision() async {
    final database = await db;
    final result = await database.query('DECISION',
        orderBy: 'ID_TYPE_PR, ID_STATE, ID_DEC');
    return result.map((e) => Decision.fromJson(e)).toList();
  }

  Future<List<AccessState>> getAccessState() async {
    final database = await db;
    final result = await database.query('ACCESS_STATE',
        orderBy: 'ID_TYPE_PR, ID_GR, ID_STATE');
    return result.map((e) => AccessState.fromJson(e)).toList();
  }

  Future<List<Predicat>> getPredicat() async {
    final database = await db;
    final result = await database.query('PREDICAT', orderBy: 'ID_PRED');
    return result.map((e) => Predicat.fromJson(e)).toList();
  }

  Future<List<Formula>> getFormula() async {
    final database = await db;
    final result =
        await database.query('FORMULA', orderBy: 'ID_F, NUM_DIS, NUM_CON');
    return result.map((e) => Formula.fromJson(e)).toList();
  }

  Future<List<ProcessEntity>> getProcess() async {
    final database = await db;
    final result = await database.query('PROCESS', orderBy: 'ID_PROCESS');
    return result.map((e) => ProcessEntity.fromJson(e)).toList();
  }

  Future<List<Trajectory>> getTrajectory() async {
    final database = await db;
    final result =
        await database.query('TRAJECTORY', orderBy: 'ID_PROCESS, NUM_POS');
    return result.map((e) => Trajectory.fromJson(e)).toList();
  }

  // Аналог функции READ_TRAJECTORY(pIdProcess)
  Future<List<Map<String, dynamic>>> readTrajectory(int pIdProcess) async {
    final database = await db;
    final sql = '''
      SELECT 
        t.NUM_POS as num_pos,
        ts.NAME as state_name,
        td.NAME as decision_name,
        p.FIO as fio,
        t.D_TIME as d_time
      FROM TRAJECTORY t
      JOIN TYPE_STATE ts ON ts.ID_STATE = t.ID_STATE
      JOIN TYPE_DECISION td ON td.ID_DEC = t.ID_DEC
      JOIN PERSON p ON p.ID_PER = t.ID_PER
      WHERE t.ID_PROCESS = ?
      ORDER BY t.NUM_POS
    ''';
    return await database.rawQuery(sql, [pIdProcess]);
  }
}
