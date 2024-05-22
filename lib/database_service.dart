import 'dart:developer';

import 'package:mispris_course/entity/unit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'entity/chem_class.dart';
import 'entity/prod.dart';

enum TableName {
  unit('units'),
  chemClass('chem_class'),
  prod('prod');

  const TableName(this.name);

  final String name;
}

abstract class DatabaseInterface {
  //SELECT *

  ///Получение всех
  Future<List<ChemClass>> getAllChemClass();
  Future<List<Prod>> getAllProds();
  Future<List<Unit>> getAllUnits();

  //UNIT

  ///[shortName] - short_name_param
  ///[name] - name_param
  ///[code] - code_param
  Future<void> addUnit(
      String? shortNameParam, String? nameParam, String? codeParam);

  ///[unitId] - unit_id
  Future<void> deleteUnit(int? unitId);

  //ChemClass

  ///[shortName] - short_name_param
  ///[name] - name_param
  ///[baseUnits] - base_units_param
  ///[mainClass] - main_class_param
  Future<void> addChemClass(
      String? shortName, String? name, int? baseUnits, int? mainClass);

  ///[classId] - class_id
  Future<void> deleteChemClass(int? classId);

  ///Процедура изменения родителя у класса изделия
  ///[classId] - class_id
  ///[newParentId] - new_parent_id
  Future<void> changeParent(int? classId, int? newParentId);

  //PROD

  ///Процедура добавления нового продукта в таблицу prod
  ///[shortName] - short_name_param
  ///[name] - name_param
  ///[idClass] - id_class_param
  Future<void> addProd(String? shortName, String? name, int? idClass);

  /// Процедура удаления продукта из таблицы prod
  ///[productId] - product_id
  Future<void> deleteProd(int? productId);

  //OTHER

  ///Процедура нахождения родителей у класса изделия
  ///[inElementId] - in_element_id
  Future<List<ChemClass>> findParents(int? inElementId);

  ///Процедура нахождения потомков у класса изделия
  ///[inputIdClass] - input_id_class
  Future<List<ChemClass>> findChildred(int? inputIdClass);
}

class DataBaseService implements DatabaseInterface {
  Database? _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'mispris.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _init() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await database.execute('''
    CREATE TABLE ${TableName.unit.name} (
      id_units INTEGER PRIMARY KEY,
      short_name TEXT(10),
      name TEXT(50),
      code TEXT(15)
    );
''');
    await database.execute('''
    CREATE TABLE ${TableName.chemClass.name} (
    id_class INTEGER PRIMARY KEY,
    short_name TEXT(50),
    name TEXT(200),
    base_units INTEGER,
    main_class INTEGER
    );  
''');
    await database.execute('''
    CREATE TABLE ${TableName.prod.name} (
    id_prod INTEGER PRIMARY KEY,
    short_name TEXT(50),
    name TEXT(250),
    id_class INTEGER NOT NULL
);  
''');
  }

  @override
  Future<void> addChemClass(
      String? shortName, String? name, int? baseUnits, int? mainClass) async {
    try {
      final database = await db;
      await database.insert(
        TableName.chemClass.name,
        ChemClass.toMapAdd(shortName, name, baseUnits, mainClass),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> addProd(String? shortName, String? name, int? idClass) async {
    try {
      final database = await db;
      await database.insert(
        TableName.prod.name,
        Prod.toMapAdd(shortName, name, idClass),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> addUnit(String? shortName, String? name, String? code) async {
    try {
      final database = await db;
      await database.insert(
        TableName.unit.name,
        Unit.toMapAdd(shortName, name, code),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> changeParent(int? classId, int? newParentId) {
    // TODO: implement changeParent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChemClass(int? classId) async {
    try {
      if (classId == null) {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.chemClass.name}');
      }
      final database = await db;
      await database.delete(
        TableName.chemClass.name,
        where: 'id_class = ?',
        whereArgs: [classId],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> deleteProd(int? productId) async {
    try {
      if (productId == null) {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.prod.name}');
      }
      final database = await db;
      await database.delete(
        TableName.prod.name,
        where: 'id_prod = ?',
        whereArgs: [productId],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> deleteUnit(int? unitId) async {
    try {
      if (unitId == null) {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.unit.name}');
      }
      final database = await db;
      await database.delete(
        TableName.prod.name,
        where: 'id_units = ?',
        whereArgs: [unitId],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<ChemClass>> findChildred(int? inputIdClass) {
    // TODO: implement findChildred
    throw UnimplementedError();
  }

  @override
  Future<List<ChemClass>> findParents(int? inElementId) {
    // TODO: implement findParents
    throw UnimplementedError();
  }

  @override
  Future<List<ChemClass>> getAllChemClass() async {
    try {
      final database = await db;
      final data = await database.query(TableName.chemClass.name);
      return List.generate(
          data.length, (index) => ChemClass.fromJson(data[index]));
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  @override
  Future<List<Prod>> getAllProds() {
    // TODO: implement getAllProds
    throw UnimplementedError();
  }

  @override
  Future<List<Unit>> getAllUnits() {
    // TODO: implement getAllUnits
    throw UnimplementedError();
  }
}
