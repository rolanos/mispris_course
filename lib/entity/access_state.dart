class AccessState {
  final int idTypePr;
  final int idGroup;
  final int idState;

  AccessState({
    required this.idTypePr,
    required this.idGroup,
    required this.idState,
  });

  factory AccessState.fromJson(Map<String, dynamic> json) => AccessState(
        idTypePr: json['ID_TYPE_PR'],
        idGroup: json['ID_GR'],
        idState: json['ID_STATE'],
      );

  Map<String, dynamic> toJson() => {
        'ID_TYPE_PR': idTypePr,
        'ID_GR': idGroup,
        'ID_STATE': idState,
      };
}
