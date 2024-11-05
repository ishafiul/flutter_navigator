import 'package:flutter/widgets.dart';
import 'package:flutter_navigator/src/controller/open_route_service/audio_instruction_controller.dart';

import 'package:flutter_navigator/src/model/instructions_coords_and_index_list.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/utils/calculator_utils.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// [NavigationInstructionController] holds all the logic for showing the navigation instruction
/// on the screen.
///
class NavigationInstructionController extends ChangeNotifier {
  NavigationInstructionController({
    required OpenrouteserviceResponse directionRouteResponse,
    required this.audioInstructionController,
  }) {
    computeInstructionsCoordsAndIndex(directionRouteResponse);
  }

  /// [AudioInstructionController] instance
  ///
  final AudioInstructionController audioInstructionController;

  /// Private [Instruction] instance variable
  ///
  InstructionStep? _instruction;

  /// Getter for [_instruction]
  ///
  InstructionStep? get instruction => _instruction;

  /// [InstructionsCoordsAndIndexList] instance
  ///
  InstructionsCoordsAndIndexList? instructionsCoordsAndIndexList;

  /// Updates [_instruction]
  ///
  void updateInstructions(InstructionStep instruction) {
    _instruction = instruction;
    notifyListeners();
  }

  /// compute instructions cordinates and index
  ///
  void computeInstructionsCoordsAndIndex(
    OpenrouteserviceResponse directionRouteResponse,
  ) {
    final instructions = directionRouteResponse
            .features.first.properties.segments.first.steps.reversed
            .toList();

    final indexList = <int>[];
    final instructionsCoordList = <List<double>>[];

    for (final instruction in instructions) {
      final index = instruction.wayPoints[0];
      indexList.add(index);
      instructionsCoordList.add(
        directionRouteResponse.features.first.geometry.coordinates[index],
      );
    }

    instructionsCoordsAndIndexList =
        InstructionsCoordsAndIndexList(instructionsCoordList, indexList);
  }

  Future<void> checkIsCoordinateInsideCircle({
    required OpenrouteserviceResponse directionRouteResponse,
    required LatLng usersLatLng,
  }) async {
    final instructionsCoordsIndexListAndUsersLoc =
        InstructionsCoordsIndexListAndUsersLoc(
      instructionsCoordsAndIndexList!.instructionsCoordsList,
      instructionsCoordsAndIndexList!.instructionsIndexList,
      directionRouteResponse,
      usersLatLng,
    );
    final instruction =
        computingCoordinateInsideCircle(instructionsCoordsIndexListAndUsersLoc);
    // await compute(computingCoordinateInsideCircle,
    //     instructionsCoordsIndexListAndUsersLoc);
    debugPrint(
      'RouteNavigationRouteController outCompute ${instruction?.toJson()}',
    );

    if (instruction?.instruction != null &&
        instruction!.instruction.isNotEmpty) {
      // update the intruction with response
      updateInstructions(instruction);
      audioInstructionController.speakInstruction(instruction: instruction);
    }

    // AudioInstruction audioInstruction = AudioInstruction(tts: tts.value, instructions: instructions, enableAudio: enabledAudio.value,
    //     instructionsList: hadSpokenInstructions, instructionsIdentifier: hadSpokenInstructionsIdentifier );
    //
    // await compute(computeAndPlayInstructionAudio, audioInstruction);
  }

  InstructionStep? computingCoordinateInsideCircle(
    InstructionsCoordsIndexListAndUsersLoc
        instructionsCoordsIndexListAndUsersLoc,
  ) {
    final directionRouteResponse1 =
        instructionsCoordsIndexListAndUsersLoc.directionRouteResponse;
    InstructionStep? instruction;
    final instructionPoints =
        instructionsCoordsIndexListAndUsersLoc.instructionsCoordsList;

    if (instructionPoints.isNotEmpty) {
      for (var index = 0; index < instructionPoints.length; index++) {
        /*print('hola ${
            directionRouteResponse1
                .features.first.properties.segments.first.steps.reversed
                .toList()[index].toJson()
        }');*/
        if (CalculatorUtils.isCoordinateInside(
          instructionLatLng: LatLng(
            instructionPoints[index][1],
            instructionPoints[index][0],
          ),
          usersLatLng: instructionsCoordsIndexListAndUsersLoc.usersLatLng,
        )) {
          // TODO: make he direction route response a single variable
          print('hola ${
            directionRouteResponse1
                .features.first.properties.segments.first.steps.reversed
                .toList()[index]
          }');
          instruction = directionRouteResponse1
              .features.first.properties.segments.first.steps.reversed
              .toList()[index];
          /*debugPrint(
            'RouteNavigationRouteController compute : ${directionRouteResponse1.features.first.properties.segments.first.steps[index].toJson()}',
          );*/
        }
        // else{
        //    instruction = directionRouteResponse1.paths![0].instructions![index];
        // }
      }
    }
    return instruction;
  }
}
