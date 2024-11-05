import 'package:flutter/foundation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class UserLocationNotifier extends ChangeNotifier {
  /// instance variable which gives distance between two coordinates
  ///
  UserLocation? _userLocation;

  /// Getter for the [_distance]
  ///
  UserLocation? get userLocation => _userLocation;

  /// Set the distance btn two cords
  ///
  void setUserLocation({
    required UserLocation userLocation,
  }) {
    _userLocation = userLocation;
    notifyListeners();
  }
}
