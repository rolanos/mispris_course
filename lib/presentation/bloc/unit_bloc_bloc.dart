import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/unit.dart';

part 'unit_bloc_event.dart';
part 'unit_bloc_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial(units: [])) {
    on<AddUnit>((event, emit) async {
      try {
        await DataBaseService().addUnit(
          event.shortName,
          event.name,
          event.code,
        );
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });

    on<DeleteUnit>((event, emit) async {
      try {
        await DataBaseService().deleteUnit(
          event.unitId,
        );
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });

    on<GetAllUnits>((event, emit) async {
      try {
        final res = await DataBaseService().getAllUnits();
        emit(UnitInitial(units: res));
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });
  }
}
