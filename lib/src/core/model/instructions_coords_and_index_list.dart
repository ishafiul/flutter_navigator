import 'package:flutter_navigator/src/core/model/direction_route_response.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class InstructionsCoordsAndIndexList {
  InstructionsCoordsAndIndexList(
      this.instructionsCoordsList, this.instructionsIndexList);
  List<List<double>> instructionsCoordsList;
  List<int> instructionsIndexList;
}

class InstructionsCoordsIndexListAndUsersLoc {
  InstructionsCoordsIndexListAndUsersLoc(
    this.instructionsCoordsList,
    this.instructionsIndexList,
    this.directionRouteResponse,
    this.usersLatLng,
  );
  List<List<double>> instructionsCoordsList;
  List<int> instructionsIndexList;
  DirectionRouteResponse directionRouteResponse;
  LatLng usersLatLng;
}
