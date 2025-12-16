import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/entity.dart';
import 'package:mispris_course/presentation/list_page/cubit/decision_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/person_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/proccess_cubit.dart';
import 'package:mispris_course/presentation/list_page/cubit/state_cubit.dart';

import '../cubit/trajectory_result_cubit.dart';

class WriteDec2Dialog extends StatefulWidget {
  const WriteDec2Dialog({
    super.key,
  });

  @override
  State<WriteDec2Dialog> createState() => _WriteDec2DialogState();
}

class _WriteDec2DialogState extends State<WriteDec2Dialog> {
  final _formKey = GlobalKey<FormState>();

  ProcessEntity? _idProcess;
  StateEntity? _idState;
  Decision? _idDec;
  Person? _idPer;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить запись (WRITE_DEC2)'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ProccessCubit, ProccessState>(
                builder: (context, state) {
                  return DropdownButton<ProcessEntity>(
                    value: _idProcess,
                    items: List.generate(
                      state.values.length,
                      (i) => DropdownMenuItem(
                        value: state.values[i],
                        child: Text(
                          state.values[i].name ?? '-',
                        ),
                      ),
                    ),
                    hint: const Text('Выберите процесс'),
                    isExpanded: true,
                    onChanged: (v) => setState(() => _idProcess = v),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<StateCubit, StateState>(
                builder: (context, state) {
                  return DropdownButton<StateEntity>(
                    value: _idState,
                    isExpanded: true,
                    items: List.generate(
                      state.values.length,
                      (i) => DropdownMenuItem(
                        value: state.values[i],
                        child: Text(
                          (state.values[i].idState ?? '-').toString(),
                        ),
                      ),
                    ),
                    hint: const Text('Выберите состояние'),
                    onChanged: (v) => setState(() => _idState = v),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<DecisionCubit, DecisionState>(
                builder: (context, state) {
                  return DropdownButton<Decision>(
                    value: _idDec,
                    items: List.generate(
                      state.values.length,
                      (i) => DropdownMenuItem(
                        value: state.values[i],
                        child: Text(
                          (state.values[i].idDec ?? '-').toString(),
                        ),
                      ),
                    ),
                    hint: const Text('Выберите решение'),
                    isExpanded: true,
                    onChanged: (v) => setState(() => _idDec = v),
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<PersonCubit, PersonState>(
                builder: (context, state) {
                  return DropdownButton<Person>(
                    value: _idPer,
                    items: List.generate(
                      state.values.length,
                      (i) => DropdownMenuItem(
                        value: state.values[i],
                        child: Text(
                          state.values[i].fio ?? '-',
                        ),
                      ),
                    ),
                    hint: const Text('Выберите исполнителя'),
                    isExpanded: true,
                    onChanged: (v) => setState(() => _idPer = v),
                  );
                },
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
              if (_idProcess != null &&
                  _idState != null &&
                  _idDec != null &&
                  _idPer != null) {
                await DatabaseService.instance.writeDec2(
                  pIdProcess: _idProcess?.id ?? 1,
                  pIdState: _idState?.idState ?? 1,
                  pIdDec: _idDec?.idDec ?? 1,
                  pIdPer: _idPer?.id ?? 1,
                );
                if (context.mounted) {
                  await context.read<TrajectoryResultCubit>().update();
                }
                Navigator.pop(context);
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
