/// Represents navigation instructions including distance, heading,
/// and other relevant information.
class Instruction {
  /// Distance to the next instruction in meters.
  final double? distance;

  /// Heading in degrees to the next instruction.
  final double? heading;

  /// Sign indicator for the instruction (if applicable).
  final int? sign;

  /// List of intervals associated with the instruction.
  final List<int>? interval;

  /// Text description of the instruction.
  final String? text;

  /// Time in seconds to reach the next instruction.
  final int? time;

  /// Name of the street associated with the instruction.
  final String? streetName;

  /// Last known heading in degrees before the instruction.
  final double? lastHeading;

  /// Constructs an [Instruction] instance with optional parameters.
  Instruction({
    this.distance,
    this.heading,
    this.sign,
    this.interval,
    this.text,
    this.time,
    this.streetName,
    this.lastHeading,
  });

  /// Creates an [Instruction] instance from a JSON object.
  ///
  /// - [json]: A [Map] representing the JSON data.
  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      distance: (json['distance'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      sign: json['sign'] as int?,
      interval: json['interval'] != null
          ? List<int>.from(json['interval'] as List<dynamic>)
          : null,
      text: json['text'] as String?,
      time: json['time'] as int?,
      streetName: json['street_name'] as String?,
      lastHeading: (json['last_heading'] as num?)?.toDouble(),
    );
  }

  /// Converts the [Instruction] instance into a JSON representation.
  ///
  /// Returns a [Map] suitable for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'heading': heading,
      'sign': sign,
      'interval': interval,
      'text': text,
      'time': time,
      'street_name': streetName,
      'last_heading': lastHeading,
    };
  }
}
