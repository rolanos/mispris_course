import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class ProccessCubit extends Cubit<ProccessState> {
  ProccessCubit() : super(ProccessLoading());

  Future<void> getData() async {
    emit(ProccessLoading());
    final values = await DatabaseService.instance.getProcess();
    emit(ProccessState(values: values));
  }
}

final class ProccessState {
  final List<ProcessEntity> values;

  ProccessState({
    this.values = const [],
  });
}

final class ProccessLoading extends ProccessState {}
