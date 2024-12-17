import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mispris_course/entity/spec_prod.dart';

import '../../database_service.dart';

part 'spec_prod_event.dart';
part 'spec_prod_state.dart';

class SpecProdBloc extends Bloc<SpecProdEvent, SpecProdState> {
  SpecProdBloc() : super(SpecProdInitial(specProds: const [])) {
    on<AddSpecProd>((event, emit) async {
      try {
        await DataBaseService().addSpecProd(
          event.idProd,
          event.positionNumber,
          event.idProdPart,
          event.quantity,
        );
        add(GetAllSpecProds());
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });

    on<DeleteSpecProd>((event, emit) async {
      try {
        await DataBaseService().deleteSpecProd(
          event.idProd,
        );
        add(GetAllSpecProds());
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });

    on<EditSpecProd>((event, emit) async {
      try {
        await DataBaseService().editSpecProd(
          idProdGeneral: event.idProd,
          positionNumber: event.positionNumber,
          newIdProdPart: event.idProdPart,
          newQuantity: event.quantity,
        );
        add(GetAllSpecProds());
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });

    on<GetAllSpecProds>((event, emit) async {
      try {
        final res = await DataBaseService().getAllSpecProds();
        emit(SpecProdInitial(specProds: res));
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });
    on<ShowSpec>((event, emit) async {
      try {
        final res = await DataBaseService().showSpec(event.idProd);
        emit(SpecProdInitial(specProds: res));
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });
    on<CountClassAmount>((event, emit) async {
      try {
        final specProds = await DataBaseService().getAllSpecProds();
        final res = await DataBaseService().countClassAmount(event.idProd);
        final prods = await DataBaseService().getAllProds();
        String message = '';
        for (final spec in res.entries) {
          final contains =
              prods.where((elem) => elem.idProd == spec.key).toList();
          if (contains.isNotEmpty) {
            message += '${contains.first.name}: ${spec.value}\n';
          }
        }
        emit(
            SpecProdInitialWithMessage(specProds: specProds, message: message));
      } catch (e) {
        emit(SpecProdError(message: e.toString()));
        add(GetAllSpecProds());
      }
    });
  }
}
