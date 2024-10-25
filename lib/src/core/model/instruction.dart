class Instruction {
  Instruction({
    double? distance,
    double? heading,
    int? sign,
    List<int>? interval,
    String? text,
    int? time,
    String? streetName,
    double? lastHeading,
  }) {
    if (distance != null) {
      this.distance = distance;
    }
    if (heading != null) {
      this.heading = heading;
    }
    if (sign != null) {
      this.sign = sign;
    }
    if (interval != null) {
      this.interval = interval;
    }
    if (text != null) {
      this.text = text;
    }
    if (time != null) {
      this.time = time;
    }
    if (streetName != null) {
      this.streetName = streetName;
    }
    if (lastHeading != null) {
      this.lastHeading = lastHeading;
    }
  }

  Instruction.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] as double?;
    heading = json['heading'] as double?;
    sign = json['sign'] as int?;
    interval = json['interval'] is List
        ? List<int>.from(json['interval'] as List<dynamic>)
        : null;
    text = json['text'] as String?;
    time = json['time'] as int?;
    streetName = json['street_name'] as String?;
    lastHeading = json['last_heading'] as double?;
  }
  double? distance;
  double? heading;
  int? sign;
  List<int>? interval;
  String? text;
  int? time;
  String? streetName;
  double? lastHeading;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['distance'] = distance;
    data['heading'] = heading;
    data['sign'] = sign;
    data['interval'] = interval;
    data['text'] = text;
    data['time'] = time;
    data['street_name'] = streetName;
    data['last_heading'] = lastHeading;
    return data;
  }
}
