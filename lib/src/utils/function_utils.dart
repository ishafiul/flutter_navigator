import 'dart:math';
import 'package:maplibre_gl/maplibre_gl.dart';

String calculateTime({required int milliseconds}) {
  final timeInMinutes = (milliseconds / (1000 * 60)).floor();

  if (timeInMinutes >= 60 * 24 * 29) {
    return 'infinity';
  } else if (timeInMinutes >= 60 * 24) {
    return '${timeInMinutes ~/ (60 * 24)} d';
  } else if (timeInMinutes >= 60) {
    return '${timeInMinutes ~/ 60} hrs';
  } else if (timeInMinutes > 0) {
    return '$timeInMinutes mins.';
  } else {
    return '${(milliseconds / 1000).round()} secs.';
  }
}

String calculateDistanceString({required double distanceInMeter}) {
  var distanceString = '$distanceInMeter M';
  if (distanceInMeter > 500.0) {
    distanceString = '${(distanceInMeter / 1000).toStringAsFixed(2)} Km.';
  } else {
    distanceString = '${distanceInMeter.toStringAsFixed(2)} M.';
  }
  return distanceString;
}

double calculateDistance(LatLng startLatLng, LatLng endLatLng) {
  // Distance in meters; for kilometers, divide the result by 1000
  const earthRadiusMeters = 6371000; // Earth's radius in meters
  const radianMultiplier = 0.017453292519943295; // π / 180

  final lat1 = startLatLng.latitude * radianMultiplier;
  final lat2 = endLatLng.latitude * radianMultiplier;
  final deltaLat =
      (endLatLng.latitude - startLatLng.latitude) * radianMultiplier;
  final deltaLng =
      (endLatLng.longitude - startLatLng.longitude) * radianMultiplier;

  final a =
      0.5 - cos(deltaLat) / 2 + cos(lat1) * cos(lat2) * (1 - cos(deltaLng)) / 2;
  final distance = 2 * earthRadiusMeters * asin(sqrt(a));

  return distance;
}

bool isCoordinateInside({
  required LatLng instructionLatLng,
  required LatLng usersLatLng,
  double radius = 0.0002,
}) {
  final circleX = instructionLatLng.longitude;
  final circleY = instructionLatLng.latitude;
  final x = usersLatLng.longitude;
  final y = usersLatLng.latitude;

  final distanceFromCircleOfCenter =
      (x - circleX) * (x - circleX) + (y - circleY) * (y - circleY);

  if (distanceFromCircleOfCenter <= radius * radius) {
    return true;
  } else {
    return false;
  }
}
/*

Future<Step?> computingCoordinateInsideCircle(
  InstructionsCoordsIndexListAndUsersLoc instructionsCoordsIndexListAndUsersLoc,
) async {
  final directionRouteResponse1 =
      instructionsCoordsIndexListAndUsersLoc.directionRouteResponse;
  Step? instruction;
  final instructionPoints =
      instructionsCoordsIndexListAndUsersLoc.instructionsCoordsList;

  if (instructionPoints.isNotEmpty) {
    for (var index = 0; index < instructionPoints.length; index++) {
      if (isCoordinateInside(
        instructionLatLng:
            LatLng(instructionPoints[index][1], instructionPoints[index][0]),
        usersLatLng: instructionsCoordsIndexListAndUsersLoc.usersLatLng,
      )) {
        instruction = directionRouteResponse1.paths![0].instructions!.reversed
            .toList()[index];

        calculateDistance(
          instructionsCoordsIndexListAndUsersLoc.usersLatLng,
          LatLng(instructionPoints[index][1], instructionPoints[index][0]),
        );
      }
      // else{
      //    instruction = directionRouteResponse1.paths![0].instructions![index];
      // }
    }
  }
  return instruction;
}
//
// computeAndPlayInstructionAudio(AudioInstruction audioInstruction) async {
//   switch (audioInstruction.enableAudio) {
//     case true:
//       var routeNavigationRouteController = RouteNavigationRouteController();
//       // TextToSpeech tts =TextToSpeech();
//       if (!audioInstruction.instructionsIdentifier.contains(
//           '${audioInstruction.instructions.distance}_${audioInstruction.instructions.sign}_${audioInstruction.instructions.time}')) {
//         routeNavigationRouteController.addHadSpokenInstructionsToList(
//             instructions: audioInstruction.instructions);
//
//         debugPrint(
//             'RouteNavigationRouteController addHadSpoken computeAndPlayInstructionAudio : ${audioInstruction.instructionsIdentifier.toString()}');
//         // await audioInstruction.tts.setLanguage('en-US');
//         // await audioInstruction.tts.speak(audioInstruction.instructions.text! );
//       }
//       break;
//
//     case false:
//       // await audioInstruction.tts.stop();
//       break;
//   }
// }
*/
