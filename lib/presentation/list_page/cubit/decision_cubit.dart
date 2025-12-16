import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class DecisionCubit extends Cubit<DecisionState> {
  DecisionCubit() : super(DecisionLoading());

  Future<void> getData() async {
    emit(DecisionLoading());
    final values = await DatabaseService.instance.getDecision();
    emit(DecisionState(values: values));
  }
}

final class DecisionState {
  final List<Decision> values;

  DecisionState({
    this.values = const [],
  });
}

final class DecisionLoading extends DecisionState {}
