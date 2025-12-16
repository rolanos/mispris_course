import 'package:flutter/material.dart';
import 'package:mispris_course/entity/type_process.dart';

import '../../../../database_service.dart';

class TypeProcessDialog extends StatefulWidget {
  const TypeProcessDialog({super.key});

  @override
  State<TypeProcessDialog> createState() => _TypeProcessDialogState();
}

class _TypeProcessDialogState extends State<TypeProcessDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();
  final TextEditingController _idClassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _idClassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить тип процесса'),
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
              const SizedBox(height: 12),
              TextFormField(
                controller: _idClassController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID_CLASS',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите ID_CLASS' : null,
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
                final idClass = int.tryParse(_idClassController.text.trim());
                if (idClass == null) {
                  return;
                }
                final person = TypeProcess(
                  name: _nameController.text.trim(),
                  shortName: _shortNameController.text.trim(),
                  idClass: idClass,
                );
                (await DatabaseService.instance.db).insert(
                  'TYPE_PROCESS',
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
