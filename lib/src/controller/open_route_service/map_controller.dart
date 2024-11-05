import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_navigator/src/controller/open_route_service/navigation_instruction_controller.dart';
import 'package:flutter_navigator/src/controller/open_route_service/speed_notifier.dart';
import 'package:flutter_navigator/src/controller/open_route_service/user_location_notifire.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/utils/map_utils.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

///
/// Notifier class for [MapScreen]
///
class MapScreenController extends ChangeNotifier {
  ///
  /// [NavigationInstructionController] instance
  ///
  final NavigationInstructionController navigationInstructionController;
  final UserLocationNotifier userLocationNotifier;

  /// [UserSpeedNotifier] instance
  ///
  final UserSpeedNotifier userSpeedNotifier;

  /// [DirectionRouteResponse] instance variable that comes from Api Call.
  ///
  final OpenrouteserviceResponse directionRouteResponse;

  /// Creates [MapScreenController] instance
  ///
  MapScreenController({
    required this.navigationInstructionController,
    required this.userSpeedNotifier,
    required this.directionRouteResponse,
    required this.userLocationNotifier,
  });

  /// private [MapLibreMapController] instance
  ///
  MapLibreMapController? _mapController;

  /// Getter for mapbox controller instance
  ///
  MapLibreMapController? get mapController => _mapController;

  /// User's starting Location circle
  ///
  Circle? startingUserLocationCircle;

  /// Map zoom level
  ///
  double mapZoomLevel = 18;

  /// Bearing value btn two co-ordinates
  ///
  double bearingBtnTwoCoords = 0;

  /// User's starting location [UserLocation]
  ///
  final UserLocation userLocation = UserLocation(
    position: const LatLng(23.823731, 90.36402),
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
  );

  /// Method to handle on map created callback
  ///
  void onMapCreated({
    required MapLibreMapController mapLibreMapController,
    VoidCallback? extraFunc,
  }) {
    // initialize map controller
    _mapController = mapLibreMapController;

    if (_mapController == null) return;

    // listener for the zoom level
    _mapController!.addListener(
      () {
        mapZoomLevel = _mapController!.cameraPosition!.zoom;
      },
    );

    // if there are extra computations to be performed then
    if (extraFunc != null) {
      extraFunc.call();
    }
  }

  /// onUserLocationUpdated call back for maplibre map controller
  ///
  Future<void> onUserLocationUpdated(UserLocation location) async {
    final position = location.position;
    userLocationNotifier.setUserLocation(userLocation: location);
    // Update user location with real-time data
    final userLocation1 = UserLocation(
      position: LatLng(position.latitude, position.longitude),
      altitude: location.altitude,
      bearing: location.bearing,
      speed: location.speed,
      horizontalAccuracy: location.horizontalAccuracy,
      verticalAccuracy: location.verticalAccuracy,
      timestamp: DateTime.now(),
      heading: location.heading,
    );

    await updateUserLocationCircleAndAnimate(userLocation1);

    // Calculate bearing if necessary
    // Assuming there's a previous location saved for bearing calculation
    animateCameraWithBearingValue(
      bearingValue: location.bearing ?? 0,
    );

    /* // Calculate speed and update user speed
    Duration diff = DateTime.now().difference(dateTimePrev);
    dateTimePrev = DateTime.now();

    // Speed and distance calculation
    final speed = MapUtils.calculateSpeed(position.speed, diff.inMicroseconds);
    userSpeedNotifier.setUserSpeed(speed: speed);*/

    // Navigation instruction check
    navigationInstructionController.checkIsCoordinateInsideCircle(
      directionRouteResponse: directionRouteResponse,
      usersLatLng: userLocation1.position,
    );
  }

  /// Method to add Source and Line layer
  ///
  Future<void> addSourceAndLineLayer(
    Map<String, dynamic> modifiedResponse,
  ) async {
    // add start and end marker i.e --> green and red respectively
    await addStartAndEndMarker();

    // feature collection object
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
    await _mapController!.removeLayer('lines');
    await _mapController!.removeSource('fills');

    // Add new source and lineLayer
    await _mapController!
        .addSource('fills', GeojsonSourceProperties(data: fills));
    await _mapController!.addLineLayer(
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

  /// This method adds start and end marker which is circle
  /// [Red color] denotes the destination
  /// [Green color] denotes the starting point for the user
  ///
  Future<void> addStartAndEndMarker() async {
    // if null return
    if (_mapController == null) {
      return;
    }

    // starting circle
    startingUserLocationCircle = await _mapController!.addCircle(
      CircleOptions(
        geometry: LatLng(
          directionRouteResponse.features[0].geometry.coordinates.first[1],
          directionRouteResponse.features[0].geometry.coordinates.first[0],
        ),
        circleColor: '#00FF00',
        circleRadius: 12,
      ),
    );

    // destination circle
    await _mapController!.addCircle(
      CircleOptions(
        geometry: LatLng(
          directionRouteResponse.features[0].geometry.coordinates.last[1],
          directionRouteResponse.features[0].geometry.coordinates.last[0],
        ),
        circleColor: '#FF0000',
        circleRadius: 12,
      ),
    );
  }

  /// Method to update [UserLocation] circle
  /// And animate camera to user location
  ///
  Future<void> updateUserLocationCircleAndAnimate(
    UserLocation userLocation,
  ) async {
    if (mapController == null) return;

    final newLocationFromRes =
        LatLng(userLocation.position.latitude, userLocation.position.longitude);

    // circle options
    final circleOptions = CircleOptions(
      geometry: newLocationFromRes,
      circleColor: '#00FF00',
      circleRadius: 12,
    );

    // if there is no circle then add circle
    if (startingUserLocationCircle == null) {
      startingUserLocationCircle =
          await mapController!.addCircle(circleOptions);
    } else {
      // else update the same circle
      await mapController!
          .updateCircle(startingUserLocationCircle!, circleOptions);
    }

    //  Animate the camera to the user's location
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            userLocation.position.latitude,
            userLocation.position.longitude,
          ),
          zoom: mapZoomLevel,
          bearing: bearingBtnTwoCoords,
          // bearing: navigationController.bearingBtnCOOrds.value,
        ),
      ),
    );
  }

  /// Method to update bearing value
  ///
  void animateCameraWithBearingValue({
    required double bearingValue,
  }) {
    bearingBtnTwoCoords = bearingValue;

    mapController!.animateCamera(CameraUpdate.bearingTo(bearingBtnTwoCoords));
  }

  /// Method to animate camera to user's current location
  ///
  Future<void> animateUserToCurrentLocation({
    double? zoomLevel,
    double? bearing,
  }) async {
    // TODO: update user location as he or she starts to move using maplibre onUserLocation updated
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              userLocation.position.latitude, userLocation.position.longitude),
          zoom: zoomLevel ?? mapZoomLevel,
          bearing: bearing ?? userLocation.bearing!,
        ),
      ),
    );
  }

  /// Method to simulate routing
  ///
  Future<void> simulateRouting({bool simulateRoute = true}) async {
    final points = directionRouteResponse.features[0].geometry.coordinates;
    // https://api.openrouteservice.org/v2/directions/driving-car?api_key=your-api-key&start=90.3711,23.8367&end=90.3858,23.7559

    // hadSpokenInstructionsIdentifier.value = [];

    var dateTimePrev = DateTime.now();

    var count = 0;
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (!simulateRoute) {
        count = 0;
        timer.cancel();
      }

      if (count < points.length) {
        if (count < points.length - 1) {
          final userLocation1 = UserLocation(
            position: LatLng(points[count][1], points[count][0]),
            altitude: userLocation.altitude,
            bearing: userLocation.bearing,
            speed: userLocation.speed,
            horizontalAccuracy: userLocation.horizontalAccuracy,
            verticalAccuracy: userLocation.verticalAccuracy,
            timestamp: userLocation.timestamp,
            heading: UserHeading(
              magneticHeading: 0,
              trueHeading: 0,
              headingAccuracy: 0,
              x: 0,
              y: 0,
              z: 0,
              timestamp: userLocation.timestamp,
            ),
          );

          // animate camera with bearing value
          await updateUserLocationCircleAndAnimate(userLocation1);

          // update bearing
          animateCameraWithBearingValue(
            bearingValue: MapUtils.calculateBearingBtnTwoCords(
              startLatLng: LatLng(points[count][1], points[count][0]),
              endLatLng: LatLng(points[count + 1][1], points[count + 1][0]),
            ),
          );

          final diff = DateTime.now().difference(dateTimePrev);
          dateTimePrev = DateTime.now();

          final distanceBtnTwoCords = MapUtils.calculateDistanceBtnTwoCoords(
            startLatLng: LatLng(points[count][1], points[count][0]),
            endLatLng: LatLng(points[count + 1][1], points[count + 1][0]),
          );

          final speed =
              MapUtils.calculateSpeed(distanceBtnTwoCords, diff.inMicroseconds);

          // set the user speed
          userSpeedNotifier.setUserSpeed(speed: speed);

          // calculateSpeed(
          //     calculateDistance(LatLng(points[count][1], points[count][0]),
          //         LatLng(points[count + 1][1], points[count + 1][0])),
          //     diff.inMicroseconds);

          navigationInstructionController.checkIsCoordinateInsideCircle(
            directionRouteResponse: directionRouteResponse,
            usersLatLng: userLocation1.position,
          );
        }
      } else if (count == points.length) {
        final userLocation1 = UserLocation(
          position: LatLng(points[count - 1][1], points[count - 1][0]),
          altitude: userLocation.altitude,
          bearing: userLocation.bearing,
          speed: userLocation.speed,
          horizontalAccuracy: userLocation.horizontalAccuracy,
          verticalAccuracy: userLocation.verticalAccuracy,
          timestamp: userLocation.timestamp,
          heading: UserHeading(
            magneticHeading: 0,
            trueHeading: 0,
            headingAccuracy: 0,
            x: 0,
            y: 0,
            z: 0,
            timestamp: userLocation.timestamp,
          ),
        );

        // use map controller to animate camera with bearing value
        await updateUserLocationCircleAndAnimate(userLocation1);

        navigationInstructionController.checkIsCoordinateInsideCircle(
          directionRouteResponse: directionRouteResponse,
          usersLatLng: userLocation1.position,
        );

        timer.cancel();
      }

      count = count + 1;
    });
  }
}
