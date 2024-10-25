import 'package:flutter/widgets.dart';
import 'package:flutter_navigator/src/model/direction_route_response.dart';
import 'package:flutter_navigator/src/state/bearing_change.dart';
import 'package:flutter_navigator/src/state/core/state_initializer.dart';
import 'package:flutter_navigator/src/state/instruction.dart';
import 'package:flutter_navigator/src/state/user_location.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class FlutterNavigator extends StatefulWidget {
  final DirectionRouteResponse directionRouteResponse;

  const FlutterNavigator({super.key, required this.directionRouteResponse});

  @override
  State<FlutterNavigator> createState() => _FlutterNavigatorState();
}

class _FlutterNavigatorState extends State<FlutterNavigator> {
  late MapLibreMapController controller;
  UserLocation? userLocation;
  double mapZoomLevel = 14;
  Circle? startingUserLocationCircle;

  @override
  void initState() {
    StateInitializer();
    userLocation = UserLocationChange().userLocationState.value;

    InstructionsChange().updateInstructionsCoordinatesList(
      directionRouteResponse: widget.directionRouteResponse,
    );
    InstructionsChange().updateInstructionsIndexList(
      directionRouteResponse: widget.directionRouteResponse,
    );
    super.initState();
  }

  Future<void> _onMapCreated(MapLibreMapController c) async {
    controller = c;
    if (widget.directionRouteResponse.toJson().isNotEmpty) {
      final routeResponse = <String, dynamic>{
        'geometry': widget.directionRouteResponse.paths![0].points!.toJson(),
        'duration': widget.directionRouteResponse.paths![0].time,
        'distance': widget.directionRouteResponse.paths![0].distance,
      };
      _addStartAndEndMarker();
      _addSourceAndLineLayer(routeResponse);
    }

    controller.addListener(() {
      mapZoomLevel = controller.cameraPosition!.zoom;
    });

    // controller.onFeatureTapped.add(onFeatureTap);

    _navigateUser();

    _rotateMapOnBearingChange();
  }

  void _addStartAndEndMarker() async {
    // starting circle
    startingUserLocationCircle = await controller.addCircle(
      CircleOptions(
        geometry: LatLng(
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .first[1],
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .first[0],
        ),
        circleColor: '#00FF00', //greeen
        circleRadius: 12,
      ),
    );

    // destination circle
    await controller.addCircle(
      CircleOptions(
        geometry: LatLng(
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .last[1],
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .last[0],
        ),
        circleColor: '#FF0000', // red
        circleRadius: 12,
      ),
    );
  }

  void _addSourceAndLineLayer(Map<String, dynamic> modifiedResponse) async {
    final fills = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'id': 0,
          'properties': <String, dynamic>{},
          'geometry': modifiedResponse['geometry'],
        },
      ],
    };

    // Remove lineLayer and source if it exists
    await controller.removeLayer('lines');
    await controller.removeSource('fills');

    // Add new source and lineLayer
    await controller.addSource('fills', GeojsonSourceProperties(data: fills));
    await controller.addLineLayer(
      'fills',
      'lines',
      const LineLayerProperties(
        lineColor: '#0000FF', //blue
        lineCap: 'round',
        lineJoin: 'round',
        lineWidth: 6,
      ),
    );
  }

  void _navigateUser() {
    UserLocationChange().userLocationState.addListener(() async {
      final userLocation = UserLocationChange().userLocationState.value;
      // new location from response
      // final newLocationFromRes = LatLng(
      //   directionRouteResponse
      //       .paths![0].snappedWaypoints!.coordinates!.first[1],
      //   directionRouteResponse
      //       .paths![0].snappedWaypoints!.coordinates!.first[0],
      // );

      final newLocationFromRes = LatLng(
        userLocation.position.latitude,
        userLocation.position.longitude,
      );

      // circle options
      final circleOptions = CircleOptions(
        geometry: newLocationFromRes,
        circleColor: '#00FF00',
        circleRadius: 12,
      );

      if (startingUserLocationCircle == null) {
        startingUserLocationCircle = await controller.addCircle(circleOptions);
      } else {
        await controller.updateCircle(
          startingUserLocationCircle!,
          circleOptions,
        );
      }

      // if (userLocation != usersLastLocation) {
      //   if (symbol != null) {
      //     await controller.removeCircle(symbol!);
      //   }
      //
      //   symbol = await controller.addCircle(circleOptions);
      // } else {
      //   await controller.updateCircle(symbol!, circleOptions);
      // }
      //
      // // update users last location
      // usersLastLocation = userLocation;

      //  Animate the camera to the user's location
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              userLocation.position.latitude,
              userLocation.position.longitude,
            ),
            zoom: mapZoomLevel,
            bearing: BearingChange().bearingState.value,
          ),
        ),
      );
    });
  }

  void _rotateMapOnBearingChange() {
    BearingChange().bearingState.addListener(() {
      controller.animateCamera(
        CameraUpdate.bearingTo(BearingChange().bearingState.value),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString:
          'https://api.maptiler.com/maps/basic-v2/style.json?key=dBeUxBwm8DpdeII9BuGm',
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: () {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                widget.directionRouteResponse.paths![0].snappedWaypoints!
                    .coordinates!.first[1],
                widget.directionRouteResponse.paths![0].snappedWaypoints!
                    .coordinates!.first[0],
              ),
              zoom: mapZoomLevel,
            ),
          ),
        );
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .first[1],
          widget.directionRouteResponse.paths![0].snappedWaypoints!.coordinates!
              .first[0],
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

  @override
  void dispose() {
    StateInitializer().disposeAll();
    super.dispose();
  }
}
