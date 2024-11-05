import 'package:flutter_navigator/src/state/core/state_manager.dart';
import 'package:flutter_navigator/src/state/core/value_wraper.dart';

class BearingController {
  factory BearingController() {
    _instance ??= BearingController._privateConstructor();
    return _instance!;
  }

  BearingController._privateConstructor();

  static BearingController? _instance = BearingController._privateConstructor();

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
