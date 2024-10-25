
import 'package:flutter_navigator/src/model/direction_route_response.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// A class that holds a list of instructions coordinates and a list of instructions index.
class InstructionsCoordsAndIndexList {
  /// The constructor.
  ///
  /// [instructionsCoordsList] - A list of instructions coordinates.
  /// [instructionsIndexList] - A list of instructions index.
  InstructionsCoordsAndIndexList(
      this.instructionsCoordsList, this.instructionsIndexList);

  /// A list of instructions coordinates.
  final List<List<double>> instructionsCoordsList;

  /// A list of instructions index.
  final List<int> instructionsIndexList;
}

/// A class that holds a list of instructions coordinates, a list of instructions index,
/// a direction route response and a user's location.
class InstructionsCoordsIndexListAndUsersLoc {
  /// The constructor.
  ///
  /// [instructionsCoordsList] - A list of instructions coordinates.
  /// [instructionsIndexList] - A list of instructions index.
  /// [directionRouteResponse] - A direction route response.
  /// [usersLatLng] - A user's location.
  InstructionsCoordsIndexListAndUsersLoc(
    this.instructionsCoordsList,
    this.instructionsIndexList,
    this.directionRouteResponse,
    this.usersLatLng,
  );

  /// A list of instructions coordinates.
  final List<List<double>> instructionsCoordsList;

  /// A list of instructions index.
  final List<int> instructionsIndexList;

  /// A direction route response.
  final DirectionRouteResponse directionRouteResponse;

  /// A user's location.
  final LatLng usersLatLng;
}
