import 'package:flutter_navigator/src/state/core/state_manager.dart';
import 'package:flutter_navigator/src/state/core/value_wraper.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class UserLocationChange {
  final StateManager _stateManager = StateManager();

  StateValue<UserLocation> get userLocationState =>
      _stateManager.useState<UserLocation>(
        'userLocationState',
        UserLocation(
          position: const LatLng(28.987280, 80.1652),
          altitude: 1200,
          bearing: 0,
          speed: 0,
          horizontalAccuracy: 0,
          verticalAccuracy: 0,
          timestamp: DateTime.now(),
          heading: UserHeading(
            magneticHeading: 0,
            trueHeading: 0,
            headingAccuracy: 0,
            x: 0,
            y: 0,
            z: 0,
            timestamp: DateTime.now(),
          ),
        ),
      );

  void  updateUserLocation({required UserLocation userLocation}) {
    userLocationState.value = userLocation;
  }
}
