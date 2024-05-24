import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/prod.dart';

part 'prod_event.dart';
part 'prod_state.dart';

class ProdBloc extends Bloc<ProdEvent, ProdState> {
  ProdBloc() : super(ProdInitial(prods: [])) {
    on<AddProd>((event, emit) async {
      try {
        await DataBaseService().addProd(
          event.shortName,
          event.name,
          event.idClass,
        );
        add(GetAllProds());
      } catch (e) {
        emit(ProdError(message: e.toString()));
        add(GetAllProds());
      }
    });

    on<DeleteProd>((event, emit) async {
      try {
        await DataBaseService().deleteProd(
          event.productId,
        );
        add(GetAllProds());
      } catch (e) {
        emit(ProdError(message: e.toString()));
        add(GetAllProds());
      }
    });

    on<GetAllProds>((event, emit) async {
      try {
        final res = await DataBaseService().getAllProds();
        emit(ProdInitial(prods: res));
      } catch (e) {
        emit(ProdError(message: e.toString()));
        add(GetAllProds());
      }
    });
  }
}
