import 'package:flutter/cupertino.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/providers/map_controller_provider.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

//TODO: Uncomment onUser location updated call back

/// This is Map Screen which will show up after we start navigation.
///
class MapWidget extends StatelessWidget {

  /// Creates [MapWidget] insstance
  ///
  const MapWidget({
    required this.directionRouteResponse, super.key,
  });
  /// [OpenrouteserviceResponse]instance
  ///
  final OpenrouteserviceResponse directionRouteResponse;

  @override
  Widget build(BuildContext context) {
    late MapLibreMapController? mbController;
    // map controller
    final mapController = MapControllerProvider.of(context);
    //
    return MapLibreMap(
      styleString:
          'https://api.maptiler.com/maps/basic-v2/style.json?key=dBeUxBwm8DpdeII9BuGm',
      onMapCreated: (mapLibreController) async {
        mbController = mapLibreController;
        // method which gets executed after the map has been initialized
        mapController.onMapCreated(mapLibreMapController: mapLibreController);
      },
      onStyleLoadedCallback: () async {
        // function to be called after the style has been loadded
        await _onStyleLoadedCallback(
          mapController.mapController!,
          directionRouteResponse,
          mapController.mapZoomLevel,
        );
        final routeResponse = <String, dynamic>{
          'geometry':
              directionRouteResponse.features.first.geometry.toJson(),
          'duration': directionRouteResponse
              .features.first.properties.segments.first.steps.first.duration,
          'distance': directionRouteResponse
              .features.first.properties.segments.first.steps.first.distance,
        };
        await mapController.addSourceAndLineLayer(routeResponse);
      },
      onUserLocationUpdated: (location) {
        if(mbController  != null){
          mapController.onUserLocationUpdated(location);
        }
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(
          directionRouteResponse.features.first.geometry.coordinates.first.last,
          directionRouteResponse
              .features.first.geometry.coordinates.first.first,
        ),
        zoom: mapController.mapZoomLevel,
      ),
      minMaxZoomPreference: const MinMaxZoomPreference(6, 19),
      myLocationEnabled: true,
      trackCameraPosition: true,
      compassEnabled: false,
      compassViewPosition: CompassViewPosition.topRight,
      myLocationTrackingMode: MyLocationTrackingMode.trackingGps,
      myLocationRenderMode: MyLocationRenderMode.gps,

      // onUserLocationUpdated: (userLocation) {
      //   this.userLocation = userLocation;

      //   if (!isSimulateRouting) {
      //     navigationController.checkIsCoordinateInsideCircle(
      //         usersLatLng: userLocation.position);
      //     controller.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //             target: LatLng(userLocation.position.latitude,
      //                 userLocation.position.longitude),
      //             zoom: mapZoomLevel,
      //             bearing: userLocation.bearing!)));

      //     navigationController.updateSpeed(speed: userLocation.speed!);
      //     navigationController.updateBearing(bearing: userLocation.bearing!);
      //   }
      // },
      // cameraTargetBounds: CameraTargetBounds(LatLngBounds( southwest: const LatLng(26.3978980576, 80.0884245137), northeast: const LatLng(26.3978980576, 80.0884245137))),
    );
  }

  Future<void> _onStyleLoadedCallback(
    MapLibreMapController mapLibreMapController,
    OpenrouteserviceResponse directionRouteResponse,
    double zoomLevel,
  ) async {
    await mapLibreMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            directionRouteResponse
                .features.first.geometry.coordinates.first.last,
            directionRouteResponse
                .features.first.geometry.coordinates.first.first,
          ),
          zoom: zoomLevel,
        ),
      ),
    );
  }
}

