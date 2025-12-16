import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entity/process.dart';
import '../list_page/cubit/proccess_cubit.dart';
import 'cubit/trajectory_result_cubit.dart';
import 'widget/trajectory_item_widget.dart';
import 'widget/write_dec_dialog.dart';

class TrajectoryPage extends StatefulWidget {
  TrajectoryPage({super.key});

  @override
  State<TrajectoryPage> createState() => _TrajectoryPageState();
}

class _TrajectoryPageState extends State<TrajectoryPage> {
  ProcessEntity? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            Row(
              spacing: 20,
              children: [
                Flexible(
                  child: BlocBuilder<ProccessCubit, ProccessState>(
                    builder: (context, state) {
                      return DropdownButton<ProcessEntity>(
                        value: controller,
                        items: List.generate(
                          state.values.length,
                          (i) => DropdownMenuItem(
                            value: state.values[i],
                            child: Text(
                              state.values[i].name ?? '-',
                            ),
                          ),
                        ),
                        icon: SizedBox(),
                        isExpanded: true,
                        hint: const Text('Выберите процесс'),
                        onChanged: (v) async {
                          await context
                              .read<TrajectoryResultCubit>()
                              .getItems(v?.id.toString());
                          setState(() => controller = v);
                        },
                      );
                    },
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => const WriteDec2Dialog(),
                    );
                  },
                  child: const Center(
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<TrajectoryResultCubit, TrajectoryResultState>(
              builder: (context, state) {
                if (state is TrajectoryResultEmpty) {
                  return const Center(
                    child: Text(
                      'Введите номер процесса',
                    ),
                  );
                }
                if (state is TrajectoryResultError) {
                  return Center(
                    child: Text(
                      state.message,
                    ),
                  );
                }
                if (state is TrajectoryResultInitial) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) => TrajectoryItemWidget(
                      item: state.items[index],
                    ),
                    separatorBuilder: (context, index) => Center(
                      child: Container(
                        width: 3,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
