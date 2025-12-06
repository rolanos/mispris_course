class Trajectory {
  final int idProcess;
  final int numPos;
  final int idState;
  final int idDec;
  final int idPer;
  final String? dTime;

  Trajectory({
    required this.idProcess,
    required this.numPos,
    required this.idState,
    required this.idDec,
    required this.idPer,
    this.dTime,
  });

  factory Trajectory.fromJson(Map<String, dynamic> json) => Trajectory(
        idProcess: json['ID_PROCESS'],
        numPos: json['NUM_POS'],
        idState: json['ID_STATE'],
        idDec: json['ID_DEC'],
        idPer: json['ID_PER'],
        dTime: json['D_TIME'],
      );

  Map<String, dynamic> toJson() => {
        'ID_PROCESS': idProcess,
        'NUM_POS': numPos,
        'ID_STATE': idState,
        'ID_DEC': idDec,
        'ID_PER': idPer,
        'D_TIME': dTime,
      };
}
