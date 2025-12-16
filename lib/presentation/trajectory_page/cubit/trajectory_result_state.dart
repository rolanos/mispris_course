part of 'trajectory_result_cubit.dart';

@immutable
sealed class TrajectoryResultState {}

final class TrajectoryResultEmpty extends TrajectoryResultState {}

final class TrajectoryResultError extends TrajectoryResultState {
  final String message;

  TrajectoryResultError({required this.message});
}

final class TrajectoryResultInitial extends TrajectoryResultState {
  final List<TrajectoryItem> items;

  final int id;

  TrajectoryResultInitial({
    required this.items,
    required this.id,
  });
}
