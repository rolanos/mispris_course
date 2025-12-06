import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class GrPersonCubit extends Cubit<GrPersonState> {
  GrPersonCubit() : super(GrPersonLoading());

  Future<void> getData() async {
    emit(GrPersonLoading());
    final values = await DatabaseService.instance.getGrPerson();
    emit(GrPersonState(values: values));
  }
}

final class GrPersonState {
  final List<GroupPerson> values;

  GrPersonState({
    this.values = const [],
  });
}

final class GrPersonLoading extends GrPersonState {}
