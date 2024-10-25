import 'package:flutter_navigator/src/state/core/state_manager.dart';
import 'package:flutter_navigator/src/state/core/value_wraper.dart';

class DistanceValues {
  factory DistanceValues() {
    _instance ??= DistanceValues._privateConstructor();
    return _instance!;
  }

  DistanceValues._privateConstructor();

  static DistanceValues? _instance = DistanceValues._privateConstructor();

  final StateManager _stateManager = StateManager();

  StateValue<List<double>> get distanceCordinatesState =>
      _stateManager.useState<List<double>>('distanceCordinatesState', [0.0]);

  StateValue<double> get remaingDistanceState =>
      _stateManager.useState<double>('remaingDistanceState', 0);

  void updateDistanceCordinates({required double distanceCordinates}) {
    final list = <double>[double.parse(distanceCordinates.toStringAsFixed(2))];
    distanceCordinatesState.value = list;
  }

  /// Updates the remaining distance
  void updateRemaingDistance({required double remaingDistance}) {
    remaingDistanceState.value =
        double.parse(remaingDistance.toStringAsFixed(2));
  }

  static void dispose() {
    _instance = null;
  }
}
