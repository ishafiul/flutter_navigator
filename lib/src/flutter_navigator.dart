import 'package:flutter/widgets.dart';
import 'package:flutter_navigator/src/controller/open_route_service/audio_instruction_controller.dart';
import 'package:flutter_navigator/src/controller/open_route_service/map_controller.dart';
import 'package:flutter_navigator/src/controller/open_route_service/navigation_instruction_controller.dart';
import 'package:flutter_navigator/src/controller/open_route_service/speed_notifier.dart';
import 'package:flutter_navigator/src/controller/open_route_service/user_location_notifire.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/presentation/map_screen.dart';
import 'package:flutter_navigator/src/providers/audio_instruction_provider.dart';
import 'package:flutter_navigator/src/providers/instruction_controller_provider.dart';
import 'package:flutter_navigator/src/providers/map_controller_provider.dart';
import 'package:flutter_navigator/src/providers/user_speed_notifier_provider.dart';

class FlutterNavigator extends StatefulWidget {
  final OpenrouteserviceResponse directionRouteResponse;

  const FlutterNavigator({super.key, required this.directionRouteResponse});

  @override
  State<FlutterNavigator> createState() => _FlutterNavigatorState();
}

class _FlutterNavigatorState extends State<FlutterNavigator> {
  /// [AudioInstructionController] instance this class will be passed down the widget tree.
  ///
  final audioInstructionController = AudioInstructionController();

  /// [NavigationInstructionController] that will be passed down the widget tree
  ///
  late final navigationInstructionController = NavigationInstructionController(
    directionRouteResponse: widget.directionRouteResponse,
    audioInstructionController: audioInstructionController,
  );

  /// [MapScreenController] instance that will be passed down the widget tree
  ///
  late final mapScreenController = MapScreenController(
    directionRouteResponse: widget.directionRouteResponse,
    navigationInstructionController: navigationInstructionController,
    userSpeedNotifier: userSpeedNotifier,
    userLocationNotifier: UserLocationNotifier(),
  );

  final userSpeedNotifier = UserSpeedNotifier();

  @override
  Widget build(BuildContext context) {
    return UserSpeedProvider(
      userSpeedNotifier: userSpeedNotifier,
      child: NavigationInstructionProvider(
        navigationInstructionController: navigationInstructionController,
        child: MapControllerProvider(
          mapController: mapScreenController,
          child: AudioInstructionProvider(
            audioInstructionController: audioInstructionController,
            child: MapRouteNavigationScreenPage(widget.directionRouteResponse),
          ),
        ),
      ),
    );
  }
}
