import 'package:flutter/material.dart';
import 'package:mispris_course/entity/type_state.dart';

import '../../../../database_service.dart';

class TypeStateDialog extends StatefulWidget {
  const TypeStateDialog({super.key});

  @override
  State<TypeStateDialog> createState() => _TypeStateDialogState();
}

class _TypeStateDialogState extends State<TypeStateDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить тип состояния'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите название' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _shortNameController,
                decoration: const InputDecoration(
                  labelText: 'Короткое имя',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
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
                final person = TypeState(
                  name: _nameController.text.trim(),
                  shortName: _shortNameController.text.trim(),
                );
                (await DatabaseService.instance.db).insert(
                  'TYPE_STATE',
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
