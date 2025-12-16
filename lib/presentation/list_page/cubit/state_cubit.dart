import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class StateCubit extends Cubit<StateState> {
  StateCubit() : super(StateLoading());

  Future<void> getData() async {
    emit(StateLoading());
    final values = await DatabaseService.instance.getState();
    emit(StateState(values: values));
  }
}

final class StateState {
  final List<StateEntity> values;

  StateState({
    this.values = const [],
  });
}

final class StateLoading extends StateState {}
