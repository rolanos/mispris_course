part of 'chem_class_bloc.dart';

@immutable
sealed class ChemClassEvent {}

class AddChemClass extends ChemClassEvent {
  final String? shortName;
  final String? name;
  final int? baseUnits;
  final int? mainClass;

  AddChemClass({this.shortName, this.name, this.baseUnits, this.mainClass});
}

class DeleteChemClass extends ChemClassEvent {
  final int? classId;

  DeleteChemClass({
    required this.classId,
  });
}

class GetAllChemClasses extends ChemClassEvent {}

class ChangeParent extends ChemClassEvent {
  final int? classId;
  final int? newClassId;

  ChangeParent({required this.classId, required this.newClassId});
}

class FindChildren extends ChemClassEvent {
  final int? id;

  FindChildren({this.id});
}

class FindParents extends ChemClassEvent {
  final int? id;

  FindParents({this.id});
}
