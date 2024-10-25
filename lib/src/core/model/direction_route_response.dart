import 'package:flutter_navigator/src/core/model/hints.dart';
import 'package:flutter_navigator/src/core/model/info.dart';
import 'package:flutter_navigator/src/core/model/paths.dart';

class DirectionRouteResponse {
  DirectionRouteResponse({Hints? hints, Info? info, List<Paths>? paths}) {
    if (hints != null) {
      hints = hints;
    }
    if (info != null) {
      info = info;
    }
    if (paths != null) {
      paths = paths;
    }
  }

  DirectionRouteResponse.fromJson(Map<String, dynamic> json) {
    hints = json['hints'] != null
        ? Hints.fromJson(
            Map<String, dynamic>.from(json['hints'] as Map<dynamic, dynamic>),
          )
        : null;
    info = json['info'] != null
        ? Info.fromJson(json['info'] as Map<String, dynamic>)
        : null;
    if (json['paths'] != null) {
      paths = <Paths>[];
      json['paths'].forEach((v) {
        paths!.add(Paths.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  Hints? hints;
  Info? info;
  List<Paths>? paths;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (hints != null) {
      data['hints'] = hints!.toJson();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (paths != null) {
      data['paths'] = paths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
