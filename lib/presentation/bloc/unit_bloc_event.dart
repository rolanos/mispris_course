part of 'unit_bloc_bloc.dart';

abstract class UnitEvent {}

class AddUnit extends UnitEvent {
  final String? shortName;
  final String? name;
  final String? code;

  AddUnit({required this.shortName, required this.name, required this.code});
}

class DeleteUnit extends UnitEvent {
  final int? unitId;

  DeleteUnit({
    required this.unitId,
  });
}

class GetAllUnits extends UnitEvent {}
