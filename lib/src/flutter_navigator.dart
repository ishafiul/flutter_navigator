import 'package:flutter/widgets.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'core/model/direction_route_response.dart';

class FlutterNavigator extends StatelessWidget {
  final DirectionRouteResponse directionRouteResponse;
  const FlutterNavigator({super.key, required this.directionRouteResponse});

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString:
          'https://api.maptiler.com/maps/basic-v2/style.json?key=dBeUxBwm8DpdeII9BuGm',
      initialCameraPosition: CameraPosition(
        target: LatLng(
          directionRouteResponse
              .paths![0].snappedWaypoints!.coordinates!.first[1],
          directionRouteResponse
              .paths![0].snappedWaypoints!.coordinates!.first[0],
        ),
      ),
      minMaxZoomPreference: const MinMaxZoomPreference(6, 19),
      myLocationEnabled: true,
      trackCameraPosition: true,
      compassViewPosition: CompassViewPosition.topRight,
      myLocationTrackingMode: MyLocationTrackingMode.trackingGps,
      myLocationRenderMode: MyLocationRenderMode.gps,
      onUserLocationUpdated: (userLocation) {},
    );
  }
}
