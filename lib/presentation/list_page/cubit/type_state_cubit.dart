import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class TypeStateCubit extends Cubit<TypeStateState> {
  TypeStateCubit() : super(TypeStateLoading());

  Future<void> getData() async {
    emit(TypeStateLoading());
    final values = await DatabaseService.instance.getTypeState();
    emit(TypeStateState(values: values));
  }
}

final class TypeStateState {
  final List<TypeState> values;

  TypeStateState({
    this.values = const [],
  });
}

final class TypeStateLoading extends TypeStateState {}
