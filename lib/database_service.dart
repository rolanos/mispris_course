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
  Future<ChemClass> getAllChemClass();
  Future<Prod> getAllProds();
  Future<Unit> getAllUnits();

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
    ///TODO сделать создание таблиц
  }

  @override
  Future<void> addChemClass(
      String? shortName, String? name, int? baseUnits, int? mainClass) {
    // TODO: implement addChemClass
    throw UnimplementedError();
  }

  @override
  Future<void> addProd(String? shortName, String? name, int? idClass) {
    // TODO: implement addProd
    throw UnimplementedError();
  }

  @override
  Future<void> addUnit(
      String? shortNameParam, String? nameParam, String? codeParam) {
    // TODO: implement addUnit
    throw UnimplementedError();
  }

  @override
  Future<void> changeParent(int? classId, int? newParentId) {
    // TODO: implement changeParent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChemClass(int? classId) {
    // TODO: implement deleteChemClass
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProd(int? productId) {
    // TODO: implement deleteProd
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUnit(int? unitId) {
    // TODO: implement deleteUnit
    throw UnimplementedError();
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
  Future<ChemClass> getAllChemClass() {
    // TODO: implement getAllChemClass
    throw UnimplementedError();
  }

  @override
  Future<Prod> getAllProds() {
    // TODO: implement getAllProds
    throw UnimplementedError();
  }

  @override
  Future<Unit> getAllUnits() {
    // TODO: implement getAllUnits
    throw UnimplementedError();
  }
}
