import 'package:flutter/material.dart';
import 'package:mispris_course/presentation/mispris_app.dart';

import 'database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = DatabaseService.instance;
  await db.seedData();
  print(await db.readTrajectory(1));
  runApp(const MisprisApp());
}
