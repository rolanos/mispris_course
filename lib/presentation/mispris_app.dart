import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/presentation/bloc/chem_class_bloc.dart';
import 'package:mispris_course/presentation/bloc/prod_bloc.dart';
import 'package:mispris_course/presentation/bloc/unit_bloc_bloc.dart';
import 'package:mispris_course/presentation/router.dart';

class MisprisApp extends StatelessWidget {
  const MisprisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UnitBloc()..add(GetAllUnits())),
        BlocProvider(create: (context) => ProdBloc()..add(GetAllProds())),
        BlocProvider(
            create: (context) => ChemClassBloc()..add(GetAllChemClasses())),
      ],
      child: MaterialApp.router(
        title: 'Классификатор',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
