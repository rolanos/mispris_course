import 'package:flutter/material.dart';
import 'package:mispris_course/presentation/router.dart';

class MisprisApp extends StatelessWidget {
  const MisprisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Классификатор',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
