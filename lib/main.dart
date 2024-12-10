import 'package:flutter/material.dart';
import 'package:mispris_course/data_scripts.dart';
import 'package:mispris_course/presentation/mispris_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDbData();
  runApp(const MisprisApp());
}
