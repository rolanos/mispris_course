import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/trajectory_result_cubit.dart';
import 'widget/trajectory_item_widget.dart';

class TrajectoryPage extends StatelessWidget {
  TrajectoryPage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            TextField(
              controller: controller,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                hintText: 'Введите id процесса',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) async {
                await context.read<TrajectoryResultCubit>().getItems(value);
              },
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
