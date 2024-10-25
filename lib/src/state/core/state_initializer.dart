import 'package:flutter_navigator/src/state/bearing_change.dart';

class StateInitializer {
  factory StateInitializer() {
    _instance ??= StateInitializer._privateConstructor();
    return _instance!;
  }

  StateInitializer._privateConstructor(){
    BearingChange();
  }

  static StateInitializer? _instance = StateInitializer._privateConstructor();

  void disposeAll() {
    BearingChange.dispose();
  }
}
