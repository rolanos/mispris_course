import 'dart:convert';

class TrajectoryItem {
  final int numPos;
  final String stateName;
  final String decisionName;
  final String fio;
  final DateTime? dTime; // Опциональный DateTime

  TrajectoryItem({
    required this.numPos,
    required this.stateName,
    required this.decisionName,
    required this.fio,
    this.dTime,
  });

  factory TrajectoryItem.fromJson(Map<String, dynamic> json) {
    DateTime? parsedTime;
    try {
      final timeString = json['d_time'] as String?;
      if (timeString != null && timeString.isNotEmpty) {
        parsedTime = DateTime.parse(timeString);
      }
    } catch (e) {
      print('Ошибка парсинга даты: $e');
    }

    return TrajectoryItem(
      numPos: (json['num_pos'] as int?) ?? 0,
      stateName: (json['state_name'] as String?) ?? '',
      decisionName: (json['decision_name'] as String?) ?? '',
      fio: (json['fio'] as String?) ?? '',
      dTime: parsedTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num_pos': numPos,
      'state_name': stateName,
      'decision_name': decisionName,
      'fio': fio,
      'd_time': dTime?.toIso8601String() ?? '',
    };
  }

  // Метод для копирования с изменениями
  TrajectoryItem copyWith({
    int? numPos,
    String? stateName,
    String? decisionName,
    String? fio,
    DateTime? dTime,
  }) {
    return TrajectoryItem(
      numPos: numPos ?? this.numPos,
      stateName: stateName ?? this.stateName,
      decisionName: decisionName ?? this.decisionName,
      fio: fio ?? this.fio,
      dTime: dTime ?? this.dTime,
    );
  }

  @override
  String toString() {
    return 'TrajectoryItem{numPos: $numPos, state: $stateName, decision: $decisionName, fio: $fio, time: ${dTime?.toIso8601String()}}';
  }
}