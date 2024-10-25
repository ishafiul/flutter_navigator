class Points {
  Points({String? type, List<List<double>>? coordinates}) {
    if (type != null) {
      type = type;
    }
    if (coordinates != null) {
      coordinates = coordinates;
    }
  }

  Points.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    if (json['coordinates'] != null &&
        (json['coordinates'] as List).isNotEmpty) {
      coordinates = List<List<double>>.from(
        (json['coordinates'] as List).map<List<double>>((coordinate) {
          return List<double>.from(
            (coordinate as List).map<double>((element) => element as double),
          );
        }).toList(),
      );
    }
  }
  String? type;
  List<List<double>>? coordinates;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;

    return data;
  }
}
