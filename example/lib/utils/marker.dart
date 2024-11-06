import 'package:maplibre_gl/maplibre_gl.dart';

class MarkerManager {
  // Private named constructor for singleton implementation
  MarkerManager._privateConstructor();

  // Static instance of the MarkerManager
  static final MarkerManager _instance = MarkerManager._privateConstructor();

  // Getter for the instance
  static MarkerManager get instance => _instance;

  bool isMarkerAdding = false;
  Symbol? marker;

  // Function to add a marker
  Future<void> addMarker({
    required LatLng location,
    required MapLibreMapController mapController,
  }) async {
    if (isMarkerAdding) {
      return;
    }

    isMarkerAdding = true;
    if (marker != null) {
      await mapController.removeSymbol(marker!);
    }
    marker = await mapController.addSymbol(SymbolOptions(
      geometry: location,
      iconSize: 0.2,
      iconImage: 'marker_image',
    ));
    isMarkerAdding = false;
  }
}
