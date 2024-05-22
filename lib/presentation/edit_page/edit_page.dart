import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: ListView(
        children: [
          Text('data2'),
          Text('data2'),
          Text('data2'),
        ],
      ),
    );
  }
}
