import 'package:flutter/material.dart';
import 'package:mispris_course/entity/entity.dart';

import '../../../../database_service.dart';

class PersonDialog extends StatefulWidget {
  const PersonDialog({super.key});

  @override
  State<PersonDialog> createState() => _PersonDialogState();
}

class _PersonDialogState extends State<PersonDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fioController = TextEditingController();

  @override
  void dispose() {
    _fioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить человека'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _fioController,
          decoration: const InputDecoration(
            labelText: 'ФИО',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите ФИО';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              if (_formKey.currentState!.validate()) {
                final person = Person(
                  fio: _fioController.text.trim(),
                );
                (await DatabaseService.instance.db).insert(
                  'PERSON',
                  person.toJson(),
                );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            } catch (e) {
              print(e);
            }
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
