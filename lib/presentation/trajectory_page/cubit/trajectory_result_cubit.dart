import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mispris_course/database_service.dart';

import '../../../entity/trajectory_item.dart';

part 'trajectory_result_state.dart';

class TrajectoryResultCubit extends Cubit<TrajectoryResultState> {
  TrajectoryResultCubit() : super(TrajectoryResultEmpty());

  Future<void> update() async {
    final state = this.state;
    if (state is TrajectoryResultInitial) {
      await getItems(state.id.toString());
    }
  }

  Future<void> getItems(String? idProcess) async {
    final parsed = int.tryParse(idProcess ?? '');
    if (parsed == null) {
      emit(TrajectoryResultError(message: 'Укажите число'));
      return;
    }
    final items = await DatabaseService.instance.readTrajectory(parsed);
    if (items.isEmpty) {
      emit(TrajectoryResultError(
          message: 'Нет элементов для процесса №$idProcess'));
      return;
    } else {
      emit(
        TrajectoryResultInitial(
          items: items.map((elem) => TrajectoryItem.fromJson(elem)).toList(),
          id: parsed,
        ),
      );
    }
  }
}
