class Formula {
  final int idF;
  final int numDis;
  final int idPred;
  final int numCon;

  Formula({
    required this.idF,
    required this.numDis,
    required this.idPred,
    required this.numCon,
  });

  factory Formula.fromJson(Map<String, dynamic> json) => Formula(
        idF: json['ID_F'],
        numDis: json['NUM_DIS'],
        idPred: json['ID_PRED'],
        numCon: json['NUM_CON'],
      );

  Map<String, dynamic> toJson() => {
        'ID_F': idF,
        'NUM_DIS': numDis,
        'ID_PRED': idPred,
        'NUM_CON': numCon,
      };
}
