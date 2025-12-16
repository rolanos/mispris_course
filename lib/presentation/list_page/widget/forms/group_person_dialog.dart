import 'package:flutter/material.dart';
import 'package:mispris_course/database_service.dart';

import '../../../../entity/entity.dart';

class GroupPersonDialog extends StatefulWidget {
  const GroupPersonDialog({super.key});

  @override
  State<GroupPersonDialog> createState() => _GroupPersonDialogState();
}

class _GroupPersonDialogState extends State<GroupPersonDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить группу'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Название группы',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите название группы';
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
            if (_formKey.currentState!.validate()) {
              final person = GroupPerson(
                name: _nameController.text.trim(),
              );
              try {
                (await DatabaseService.instance.db).insert(
                  'GR_PERSON',
                  person.toJson(),
                );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                print(e);
              }
            }
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
