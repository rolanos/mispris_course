import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/entity/entity.dart';
import 'package:mispris_course/presentation/list_page/cubit/type_process_cubit.dart';

import '../../../../database_service.dart';

class ProcessEntityDialog extends StatefulWidget {
  const ProcessEntityDialog({super.key});

  @override
  State<ProcessEntityDialog> createState() => _ProcessEntityDialogState();
}

class _ProcessEntityDialogState extends State<ProcessEntityDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shortNameController = TextEditingController();
  TypeProcess? typeProcess;
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
      title: const Text('Добавить процесс'),
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
              BlocBuilder<TypeProcessCubit, TypeProcessState>(
                builder: (context, state) {
                  return DropdownButton<TypeProcess>(
                    hint: const Text('Укажите тип процесса'),
                    onChanged: (value) {
                      setState(() {
                        typeProcess = value;
                      });
                    },
                    value: typeProcess,
                    icon: const SizedBox(),
                    items: List.generate(
                      state.values.length,
                      (i) => DropdownMenuItem<TypeProcess>(
                        value: state.values[i],
                        child: Text(
                          state.values[i].name ?? '-',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _idClassController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ID_CLASS',
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
                if (typeProcess?.id == null) {
                  return;
                }
                final person = ProcessEntity(
                  name: _nameController.text.trim(),
                  shortName: _shortNameController.text.trim(),
                  typePr: typeProcess!.id,
                  idClass: int.tryParse(_idClassController.text.trim()),
                );
                (await DatabaseService.instance.db).insert(
                  'PROCESS',
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
