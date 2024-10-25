import 'package:flutter_navigator/src/state/core/state_manager.dart';
import 'package:flutter_navigator/src/state/core/value_wraper.dart';

class BearingChange {
  factory BearingChange() {
    _instance ??= BearingChange._privateConstructor();
    return _instance!;
  }

  BearingChange._privateConstructor();

  static BearingChange? _instance = BearingChange._privateConstructor();

  final StateManager _stateManager = StateManager();

  StateValue<double> get bearingState =>
      _stateManager.useState<double>('bearingState', 0);

  void updateBearing({required double bearing}) {
    bearingState.value = double.parse(bearing.toStringAsFixed(3));
  }

  static void dispose() {
    _instance = null;
  }
}
