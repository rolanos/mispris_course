import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/chem_class.dart';

part 'chem_class_event.dart';
part 'chem_class_state.dart';

class ChemClassBloc extends Bloc<ChemClassEvent, ChemClassState> {
  ChemClassBloc() : super(ChemClassInitial(chems: [])) {
    on<AddChemClass>((event, emit) async {
      try {
        await DataBaseService().addChemClass(
            event.shortName, event.name, event.baseUnits, event.mainClass);
        add(GetAllChemClasses());
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });

    on<DeleteChemClass>((event, emit) async {
      try {
        await DataBaseService().deleteChemClass(
          event.classId,
        );
        add(GetAllChemClasses());
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });

    on<GetAllChemClasses>((event, emit) async {
      try {
        final res = await DataBaseService().getAllChemClass();
        emit(ChemClassInitial(chems: res));
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });

    on<ChangeParent>((event, emit) async {
      try {
        await DataBaseService().changeParent(event.classId, event.newClassId);
        add(GetAllChemClasses());
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });

    on<FindChildren>((event, emit) async {
      try {
        final res = await DataBaseService().findChildren(event.id);
        emit(ChemClassInitial(chems: res));
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });

    on<FindParents>((event, emit) async {
      try {
        final res = await DataBaseService().findParents(event.id);
        emit(ChemClassInitial(chems: res));
      } catch (e) {
        emit(ChemClassError(message: e.toString()));
        add(GetAllChemClasses());
      }
    });
  }
}
