import 'package:flutter/material.dart';
import 'package:mispris_course/entity/trajectory_item.dart';

class TrajectoryItemWidget extends StatelessWidget {
  const TrajectoryItemWidget({
    super.key,
    required this.item,
  });

  final TrajectoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
         Text(item.fio,),
         Text(item.decisionName,),
         Text(item.stateName,),
        ],
      ),
    );
  }
}
