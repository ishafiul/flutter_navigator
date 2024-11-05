
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/presentation/widgets/audio_icon_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/instruction_info_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/map_compass_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/map_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/my_location_zoom_icon_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/navigation_info_widget.dart';
import 'package:flutter_navigator/src/providers/map_controller_provider.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapRouteNavigationScreenPage extends StatefulWidget {
  final OpenrouteserviceResponse directionRouteResponse;
  static const IconData compass =
  IconData(0xf8ca, fontFamily: 'iconFont', fontPackage: 'iconFontPackage');

  const MapRouteNavigationScreenPage(this.directionRouteResponse, {super.key});

  @override
  State<StatefulWidget> createState() {
    return MapRouteNavigationScreenPageState();
  }
}

class MapRouteNavigationScreenPageState
    extends State<MapRouteNavigationScreenPage> {
  late MaplibreMapController controller;

  late OpenrouteserviceResponse directionRouteResponse;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKeyRoute =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // direction route response initialization
    directionRouteResponse = widget.directionRouteResponse;
  }

  void showInSnackBar(String value) {
    _scaffoldKeyRoute.currentState?.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  Future<bool> _willPopCallback(bool didPop) async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Get.back();
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        _willPopCallback(didPop);
      },
      child: Scaffold(
        key: _scaffoldKeyRoute,
        body: SafeArea(
          child: ExpandableBottomSheet(
            persistentContentHeight: MediaQuery.of(context).size.height * 0.1,
            background: buildBackgroundUi(),
            persistentHeader: buildPersistentHeaderUi(),
            expandableContent: NavigationInfoUi(
              directionRouteResponse: directionRouteResponse,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackgroundUi() {
    return Stack(children: [
      MapWidget(
        directionRouteResponse: directionRouteResponse,
      ),
      const InstructionInfo(),
      buildCompass(),
    ]);
  }

  Widget buildCompass() {
    return Positioned(
        top: 150,
        right: 16.0,
        child: Column(
          children: [
            const MapCompassWidget(),
            const SizedBox(
              height: 20.0,
            ),
            const AudioIconWidget(),
            const SizedBox(
              height: 20.0,
            ),
            CustomFloatingActionButton(
                heroTag: 'tag_my_location_zoom',
                onPressed: () {
                  // animate user to current location
                  final mapScreenController = MapControllerProvider.of(context);
                  mapScreenController.animateUserToCurrentLocation(
                      zoomLevel: 19.0, bearing: 0.0);
                },
                iconData: Icons.gps_fixed),
          ],
        ));
  }

  Container buildPersistentHeaderUi() {
    return Container(
      height: 20,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Center(
        child: SizedBox(
          height: 6.0,
          width: MediaQuery.of(context).size.width * 0.2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(
                    3) // use instead of BorderRadius.all(Radius.circular(20))
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> loadMarkerImage(String assetsPath) async {
    var byteData = await rootBundle.load(assetsPath);
    return byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  }

// void onFeatureTap(dynamic featureId, Point point, LatLng latLng) async {
//   // Fluttertoast.showToast(msg: 'Feature ID: ${featureId.toString()} \n '
//   //     'Coordinates: ${latLng.toString()}');
// }

// Container buildExpandableContentUi() {
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.71,
//     color: Colors.white,
//     child: NavigationInfoUi(directionRouteResponse: directionRouteResponse),
//   );
// }
}
