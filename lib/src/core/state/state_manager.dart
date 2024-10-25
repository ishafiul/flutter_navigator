import 'package:flutter_navigator/src/core/state/value_wraper.dart';

class StateManager {
  final Map<String, StateValue> _states = {};

  StateValue<T> useState<T>(String key, T initialValue) {
    if (_states.containsKey(key)) {
      return _states[key]! as StateValue<T>;
    } else {
      final state = StateValue<T>(initialValue);
      _states[key] = state;
      return state;
    }
  }
}
