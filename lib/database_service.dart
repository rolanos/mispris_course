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
  Future<List<ChemClass>> findChildren(int? inputIdClass);
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

      if (!(await containsChemClass(mainClass))) {
        Exception('Не существует базового класса c id = $mainClass');
      }
      if (!(await containsUnit(baseUnits))) {
        Exception('Не существует ЕИ с id = $baseUnits');
      }
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
      if (!(await containsChemClass(idClass))) {
        Exception('Не существует базового класса c id = $idClass');
      }
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
  Future<void> changeParent(int? classId, int? newParentId) async {
    try {
      final database = await db;
      final containsChild = await containsChemClass(classId);
      final containsParent = await containsChemClass(classId);
      if (!containsChild) {
        throw Exception(
            'В таблице ${TableName.chemClass.name} нет такого изделия');
      }
      if (!containsParent) {
        throw Exception(
            'В таблице ${TableName.chemClass.name} нет такого родительского изделия');
      }

      final data = await database.query(TableName.chemClass.name,
          where: 'id_class=?', whereArgs: [classId]);

      if (data.isNotEmpty) {
        final buffer = ChemClass.fromJson(data.first);
        final result = buffer.copyWith(mainClass: newParentId);
        await database.update(
          TableName.chemClass.name,
          result.toJson(),
        );
      }
    } catch (e) {
      log(e.toString());
    }
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
  Future<List<ChemClass>> findChildren(int? inputIdClass) async {
    try {
      if (inputIdClass == null) {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.chemClass.name}');
      }
      List<ChemClass> classes = await getAllChemClass();
      return findAllChildren(classes, inputIdClass);
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  List<ChemClass> findAllChildren(List<ChemClass> classes, int idClass) {
    List<ChemClass> children = [];

    ChemClass currentClass =
        classes.firstWhere((element) => element.idClass == idClass);

    if (currentClass != null) {
      List<ChemClass> potentialChildren =
          classes.where((element) => element.mainClass == idClass).toList();

      for (ChemClass child in potentialChildren) {
        children.add(child);
        children.addAll(findAllChildren(classes, child.idClass));
      }
    }

    return children;
  }

  @override
  Future<List<ChemClass>> findParents(int? inElementId) async {
    try {
      List<ChemClass> classes = await getAllChemClass();
      List<ChemClass> parents = [];
      if (inElementId == null) {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.chemClass.name}');
      }

      if (classes
          .where((element) => element.idClass == inElementId)
          .isNotEmpty) {
        ChemClass? currentClass =
            classes.firstWhere((element) => element.idClass == inElementId);

        while (currentClass != null) {
          if (currentClass.mainClass != null) {
            if (classes.indexWhere(
                    (element) => element.idClass == currentClass!.mainClass) !=
                -1) {
              currentClass = classes.firstWhere(
                  (element) => element.idClass == currentClass!.mainClass);
              parents.add(currentClass);
            }
          } else {
            currentClass = null;
          }
        }

        return parents;
      } else {
        throw Exception(
            'Идентификатора класса не существует в таблице ${TableName.chemClass.name}');
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
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
  Future<List<Prod>> getAllProds() async {
    try {
      final database = await db;
      final data = await database.query(TableName.prod.name);
      return List.generate(data.length, (index) => Prod.fromJson(data[index]));
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  @override
  Future<List<Unit>> getAllUnits() async {
    try {
      final database = await db;
      final data = await database.query(TableName.unit.name);
      return List.generate(data.length, (index) => Unit.fromJson(data[index]));
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<bool> containsChemClass(int? id) async {
    if (id == null) {
      return false;
    }
    try {
      final database = await db;
      final data = await database.query(
        TableName.chemClass.name,
        where: 'id_class=?',
        whereArgs: [id],
      );
      return data.isNotEmpty;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> containsUnit(int? id) async {
    if (id == null) {
      return false;
    }
    try {
      final database = await db;
      final data = await database.query(
        TableName.unit.name,
        where: 'id_units=?',
        whereArgs: [id],
      );
      return data.isNotEmpty;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> containsProd(int? id) async {
    if (id == null) {
      return false;
    }
    try {
      final database = await db;
      final data = await database.query(
        TableName.unit.name,
        where: 'id_prod=?',
        whereArgs: [id],
      );
      return data.isNotEmpty;
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
