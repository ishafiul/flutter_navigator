import 'package:flutter_navigator/src/model/direction_route_response.dart';
import 'package:flutter_navigator/src/state/core/state_manager.dart';
import 'package:flutter_navigator/src/state/core/value_wraper.dart';

class InstructionsChange {
  final StateManager _stateManager = StateManager();

  StateValue<List<int>> get instructionsIndexList =>
      _stateManager.useState<List<int>>('instructionsIndexList', []);

  StateValue<List<List<double>>> get instructionsCoordinatesList =>
      _stateManager.useState<List<List<double>>>('instructionsCoordinatesList', []);

  void updateInstructionsIndexList({
    required DirectionRouteResponse directionRouteResponse,
  }) {
    final instructions =
        directionRouteResponse.paths![0].instructions?.reversed.toList() ?? [];

    final indexList = <int>[];

    for (final instruction in instructions) {
      final index = instruction.interval![0];
      indexList.add(index);
    }
    instructionsIndexList.value = indexList;
  }

  void updateInstructionsCoordinatesList({
    required DirectionRouteResponse directionRouteResponse,
  }) {
    final instructions =
        directionRouteResponse.paths![0].instructions?.reversed.toList() ?? [];

    final coordinatesList = <List<double>>[];

    for (final instruction in instructions) {
      final index = instruction.interval![0];
      coordinatesList
          .add(directionRouteResponse.paths![0].points!.coordinates![index]);
    }
    instructionsCoordinatesList.value = coordinatesList;
  }
}
