import 'package:flutter_navigator/src/state/bearing_controller.dart';

class StateInitializer {
  factory StateInitializer() {
    _instance ??= StateInitializer._privateConstructor();
    return _instance!;
  }

  StateInitializer._privateConstructor(){
    BearingController();
  }

  static StateInitializer? _instance = StateInitializer._privateConstructor();

  void disposeAll() {
    BearingController.dispose();
  }
}
