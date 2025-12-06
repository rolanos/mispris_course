import 'package:bloc/bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonLoading());

  Future<void> getData() async {
    emit(PersonLoading());
    final values = await DatabaseService.instance.getPerson();
    emit(PersonState(values: values));
  }
}

final class PersonState {
  final List<Person> values;

  PersonState({
    this.values = const [],
  });
}

final class PersonLoading extends PersonState {}
