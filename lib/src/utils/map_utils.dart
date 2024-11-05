import 'dart:math' as math;
import 'dart:math' show asin, cos, sqrt;

import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class MapUtils {
  /// Calculate Bearing value between two coordinates
  ///
  static double calculateBearingBtnTwoCords({
    required LatLng startLatLng,
    required LatLng endLatLng,
  }) {
    final lat1 = startLatLng.latitude;
    final lat2 = endLatLng.latitude;
    final lng1 = startLatLng.longitude;
    final lng2 = endLatLng.longitude;

    final dLon = lng2 - lng1;
    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
    final radian = math.atan2(y, x);
    // double bearing  = (radian * 180)/pi;
    var bearing = vector_math.degrees(radian);

    bearing = 360 - ((bearing + 360) % 360);

    return bearing;
  }

  /// Calculates Distance between two coordinates
  ///
  static double calculateDistanceBtnTwoCoords({
    required LatLng startLatLng,
    required LatLng endLatLng,
  }) {
    // distance in Meters
    // if you want distance in Kilo Meters, Just divide by 1000
    final lat1 = startLatLng.latitude;
    final lat2 = endLatLng.latitude;
    final lng1 = startLatLng.longitude;
    final lng2 = endLatLng.longitude;

    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    final distance = 12742 * asin(sqrt(a)) * 1000;

    return distance;
  }

  /// Calculate speed
  ///
  static double calculateSpeed(double distance, int time) {
    final microToSecond = time / 1000000;
    final speed = distance / microToSecond;
    // updateSpeed(speed: speed);
    return speed;
  }
}
