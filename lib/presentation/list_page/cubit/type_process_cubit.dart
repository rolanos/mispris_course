import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class TypeProcessCubit extends Cubit<TypeProcessState> {
  TypeProcessCubit() : super(TypeProcessLoading());

  Future<void> getData() async {
    emit(TypeProcessLoading());
    final values = await DatabaseService.instance.getTypeProcess();
    emit(TypeProcessState(values: values));
  }
}

final class TypeProcessState {
  final List<TypeProcess> values;

  TypeProcessState({
    this.values = const [],
  });
}

final class TypeProcessLoading extends TypeProcessState {}
