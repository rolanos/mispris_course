import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/presentation/list_page/cubit/gr_person_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/person_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/proccess_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/type_process_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/type_state_cubit.dart';
import 'package:mispris_course/presentation/router.dart';

import 'trajectory_page/cubit/trajectory_result_cubit.dart';

class MisprisApp extends StatelessWidget {
  const MisprisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GrPersonCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => PersonCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => PersonCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => ProccessCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => TypeProcessCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => TypeStateCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => TrajectoryResultCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Бизнес-логика',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
