class OpenrouteserviceResponse {
  OpenrouteserviceResponse({
    required this.type,
    required this.bbox,
    required this.features,
    required this.metadata,
  });

  factory OpenrouteserviceResponse.fromJson(Map<String, dynamic> json) =>
      OpenrouteserviceResponse(
        type: json['type'] as String,
        bbox:
            List<double>.from((json['bbox'] as List).map((x) => x?.toDouble())),
        features: List<Feature>.from(
          (json['features'] as List)
              .map((x) => Feature.fromJson(x as Map<String, dynamic>)),
        ),
        metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      );
  String type;
  List<double> bbox;
  List<Feature> features;
  Metadata metadata;

  OpenrouteserviceResponse copyWith({
    String? type,
    List<double>? bbox,
    List<Feature>? features,
    Metadata? metadata,
  }) =>
      OpenrouteserviceResponse(
        type: type ?? this.type,
        bbox: bbox ?? this.bbox,
        features: features ?? this.features,
        metadata: metadata ?? this.metadata,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'bbox': List<dynamic>.from(bbox.map((x) => x)),
        'features': List<dynamic>.from(features.map((x) => x.toJson())),
        'metadata': metadata.toJson(),
      };
}

class Feature {
  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        bbox:
            List<double>.from((json['bbox'] as List).map((x) => x?.toDouble())),
        type: json['type'] as String,
        properties:
            Properties.fromJson(json['properties'] as Map<String, dynamic>),
        geometry: Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      );
  List<double> bbox;
  String type;
  Properties properties;
  Geometry geometry;

  Feature copyWith({
    List<double>? bbox,
    String? type,
    Properties? properties,
    Geometry? geometry,
  }) =>
      Feature(
        bbox: bbox ?? this.bbox,
        type: type ?? this.type,
        properties: properties ?? this.properties,
        geometry: geometry ?? this.geometry,
      );

  Map<String, dynamic> toJson() => {
        'bbox': List<dynamic>.from(bbox.map((x) => x)),
        'type': type,
        'properties': properties.toJson(),
        'geometry': geometry.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(
          (json['coordinates'] as List).map(
            (x) => List<double>.from((x as List).map((x) => x?.toDouble())),
          ),
        ),
        type: json['type'] as String,
      );
  List<List<double>> coordinates;
  String type;

  Geometry copyWith({
    List<List<double>>? coordinates,
    String? type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() => {
        'coordinates': List<dynamic>.from(
          coordinates.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        'type': type,
      };
}

class Properties {
  Properties({
    required this.segments,
    required this.summary,
    required this.wayPoints,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        segments: List<Segment>.from(
          (json['segments'] as List)
              .map((x) => Segment.fromJson(x as Map<String, dynamic>)),
        ),
        summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
        wayPoints: List<int>.from((json['way_points'] as List).map((x) => x)),
      );
  List<Segment> segments;
  Summary summary;
  List<int> wayPoints;

  Properties copyWith({
    List<Segment>? segments,
    Summary? summary,
    List<int>? wayPoints,
  }) =>
      Properties(
        segments: segments ?? this.segments,
        summary: summary ?? this.summary,
        wayPoints: wayPoints ?? this.wayPoints,
      );

  Map<String, dynamic> toJson() => {
        'segments': List<dynamic>.from(segments.map((x) => x.toJson())),
        'summary': summary.toJson(),
        'way_points': List<dynamic>.from(wayPoints.map((x) => x)),
      };
}

class Segment {
  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        distance: json['distance'] as double,
        duration: json['duration'] as double,
        steps: List<InstructionStep>.from(
          (json['steps'] as List)
              .map((x) => InstructionStep.fromJson(x as Map<String, dynamic>)),
        ),
      );
  double distance;
  double duration;
  List<InstructionStep> steps;

  Segment copyWith({
    double? distance,
    double? duration,
    List<InstructionStep>? steps,
  }) =>
      Segment(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        steps: steps ?? this.steps,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'steps': List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class InstructionStep {
  InstructionStep({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
    this.exitNumber,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> json) => InstructionStep(
        distance: json['distance'] as double,
        duration: json['duration'] as double,
        type: json['type'] as int,
        instruction: json['instruction'] as String,
        name: json['name'] as String,
        wayPoints: List<int>.from((json['way_points'] as List).map((x) => x)),
        exitNumber: json['exit_number'] as int?,
      );
  double distance;
  double duration;
  int type;
  String instruction;
  String name;
  List<int> wayPoints;
  int? exitNumber;

  InstructionStep copyWith({
    double? distance,
    double? duration,
    int? type,
    String? instruction,
    String? name,
    List<int>? wayPoints,
    int? exitNumber,
  }) =>
      InstructionStep(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        type: type ?? this.type,
        instruction: instruction ?? this.instruction,
        name: name ?? this.name,
        wayPoints: wayPoints ?? this.wayPoints,
        exitNumber: exitNumber ?? this.exitNumber,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'type': type,
        'instruction': instruction,
        'name': name,
        'way_points': List<dynamic>.from(wayPoints.map((x) => x)),
        'exit_number': exitNumber,
      };
}

class Summary {
  Summary({
    required this.distance,
    required this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        distance: json['distance'] as double,
        duration: json['duration'] as double,
      );
  double distance;
  double duration;

  Summary copyWith({
    double? distance,
    double? duration,
  }) =>
      Summary(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
      };
}

class Metadata {
  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        attribution: json['attribution'] as String,
        service: json['service'] as String,
        timestamp: json['timestamp'] as int,
        query: Query.fromJson(json['query'] as Map<String, dynamic>),
        engine: Engine.fromJson(json['engine'] as Map<String, dynamic>),
      );
  String attribution;
  String service;
  int timestamp;
  Query query;
  Engine engine;

  Metadata copyWith({
    String? attribution,
    String? service,
    int? timestamp,
    Query? query,
    Engine? engine,
  }) =>
      Metadata(
        attribution: attribution ?? this.attribution,
        service: service ?? this.service,
        timestamp: timestamp ?? this.timestamp,
        query: query ?? this.query,
        engine: engine ?? this.engine,
      );

  Map<String, dynamic> toJson() => {
        'attribution': attribution,
        'service': service,
        'timestamp': timestamp,
        'query': query.toJson(),
        'engine': engine.toJson(),
      };
}

class Engine {
  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
  });
  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        version: json['version'] as String,
        buildDate: DateTime.parse(json['build_date'] as String),
        graphDate: DateTime.parse(json['graph_date'] as String),
      );

  String version;
  DateTime buildDate;
  DateTime graphDate;

  Engine copyWith({
    String? version,
    DateTime? buildDate,
    DateTime? graphDate,
  }) =>
      Engine(
        version: version ?? this.version,
        buildDate: buildDate ?? this.buildDate,
        graphDate: graphDate ?? this.graphDate,
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'build_date': buildDate.toIso8601String(),
        'graph_date': graphDate.toIso8601String(),
      };
}

class Query {
  Query({
    required this.coordinates,
    required this.profile,
    required this.format,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        coordinates: List<List<double>>.from(
          (json['coordinates'] as List).map(
            (x) => List<double>.from((x as List).map((x) => x?.toDouble())),
          ),
        ),
        profile: json['profile'] as String,
        format: json['format'] as String,
      );
  List<List<double>> coordinates;
  String profile;
  String format;

  Query copyWith({
    List<List<double>>? coordinates,
    String? profile,
    String? format,
  }) =>
      Query(
        coordinates: coordinates ?? this.coordinates,
        profile: profile ?? this.profile,
        format: format ?? this.format,
      );

  Map<String, dynamic> toJson() => {
        'coordinates': List<dynamic>.from(
          coordinates.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
        'profile': profile,
        'format': format,
      };
}
