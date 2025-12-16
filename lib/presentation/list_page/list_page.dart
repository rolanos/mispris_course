import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/presentation/list_page/widget/forms/group_person_dialog.dart';
import 'package:mispris_course/presentation/list_page/widget/forms/person_dialog.dart';
import 'package:mispris_course/presentation/list_page/widget/forms/process_dialog.dart';
import 'package:mispris_course/presentation/list_page/widget/forms/type_process_dialog.dart';
import 'package:mispris_course/presentation/list_page/widget/forms/type_state_dialog.dart';

import 'cubit/cubit.dart';
import 'widget/headers.dart';
import 'widget/rows.dart';

class EntitiesListPage extends StatefulWidget {
  const EntitiesListPage({super.key});

  @override
  State<EntitiesListPage> createState() => _EntitiesListPageState();
}

class _EntitiesListPageState extends State<EntitiesListPage> {
  int tableId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: tableId,
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Группы людей')),
                  DropdownMenuItem(value: 1, child: Text('Люди')),
                  DropdownMenuItem(value: 2, child: Text('Процессы')),
                  DropdownMenuItem(value: 3, child: Text('Типы состояния')),
                  DropdownMenuItem(value: 4, child: Text('Типы процессов')),
                ],
                onChanged: (v) => setState(() => tableId = v ?? 0),
              ),
              FloatingActionButton(
                onPressed: () async {
                  switch (tableId) {
                    case 0:
                      await showDialog(
                        context: context,
                        builder: (context) => const GroupPersonDialog(),
                      );
                      if (context.mounted) {
                        await context.read<GrPersonCubit>().getData();
                      }
                      break;
                    case 1:
                      await showDialog(
                        context: context,
                        builder: (context) => const PersonDialog(),
                      );
                      if (context.mounted) {
                        await context.read<PersonCubit>().getData();
                      }
                      break;
                    case 2:
                      await showDialog(
                        context: context,
                        builder: (context) => const ProcessEntityDialog(),
                      );
                      if (context.mounted) {
                        await context.read<ProccessCubit>().getData();
                      }
                      break;
                    case 3:
                      await showDialog(
                        context: context,
                        builder: (context) => const TypeStateDialog(),
                      );
                      if (context.mounted) {
                        await context.read<TypeStateCubit>().getData();
                      }
                      break;
                    case 4:
                      await showDialog(
                        context: context,
                        builder: (context) => const TypeProcessDialog(),
                      );
                      if (context.mounted) {
                        await context.read<TypeProcessCubit>().getData();
                      }
                      break;
                    default:
                  }
                },
                child: const Center(
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),

          // ==============================
          // GR_PERSON
          // ==============================
          if (tableId == 0) ...[
            const GrPersonHeader(),
            Expanded(
              child: BlocBuilder<GrPersonCubit, GrPersonState>(
                builder: (context, state) {
                  if (state is GrPersonLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          GrPersonRow(entity: state.values[index]),
                    );
                  }
                },
              ),
            ),
          ]

          // ==============================
          // PERSON
          // ==============================
          else if (tableId == 1) ...[
            const PersonHeader(),
            Expanded(
              child: BlocBuilder<PersonCubit, PersonState>(
                builder: (context, state) {
                  if (state is PersonLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          PersonRow(entity: state.values[index]),
                    );
                  }
                },
              ),
            ),
          ]

          // ==============================
          // PROCESS
          // ==============================
          else if (tableId == 2) ...[
            const ProcessHeader(),
            Expanded(
              child: BlocBuilder<ProccessCubit, ProccessState>(
                builder: (context, state) {
                  if (state is ProccessLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          ProcessRow(entity: state.values[index]),
                    );
                  }
                },
              ),
            ),
          ]

          // ==============================
          // TypeState
          // ==============================
          else if (tableId == 3) ...[
            const TypeStateHeader(),
            Expanded(
              child: BlocBuilder<TypeStateCubit, TypeStateState>(
                builder: (context, state) {
                  if (state is ProccessLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => TypeStateRow(
                        entity: state.values[index],
                      ),
                    );
                  }
                },
              ),
            ),
          ]
          // ==============================
          // TypeProccess
          // ==============================
          else if (tableId == 4) ...[
            const TypeProcessHeader(),
            Expanded(
              child: BlocBuilder<TypeProcessCubit, TypeProcessState>(
                builder: (context, state) {
                  if (state is TypeProcessCubit) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: state.values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => TypeProcessRow(
                        entity: state.values[index],
                      ),
                    );
                  }
                },
              ),
            ),
          ] else ...[
            const SizedBox()
          ],
        ],
      ),
    );
  }
}
