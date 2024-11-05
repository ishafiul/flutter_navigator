import 'package:flutter/material.dart';

class NavigationInstructionsType {
  static const int keepRight = 7;
  static const int roundAbout = 6;
  static const int arrivedAtDestination = 4;
  static const int startFromOrigin = 10;
  static const int turnSharpRight = 3;
  static const int turnRight = 2;
  static const int turnSlightRight = 1;
  static const int continueStraight = 0;
  static const int keepLeft = -7;
  static const int turnSharpLeft = -3;
  static const int turnLeft = -2;
  static const int turnSlightLeft = -1;

  static Widget getDirectionIconByInstructionType({
    required int instructionType,
  }) {
    Widget directionIcon = const SizedBox();
    switch (instructionType) {
      case NavigationInstructionsType.arrivedAtDestination:
        directionIcon = getIconWidget(Icons.location_on, iconColor: Colors.red);
      case NavigationInstructionsType.startFromOrigin:
        directionIcon =
            getIconWidget(Icons.location_on, iconColor: Colors.green);
      case NavigationInstructionsType.roundAbout:
        directionIcon = getIconWidget(Icons.circle_outlined, size: 35);
      case NavigationInstructionsType.continueStraight:
        directionIcon = getIconWidget(Icons.swipe_up_alt_outlined);

      case NavigationInstructionsType.turnSlightLeft:
        directionIcon = getIconWidget(Icons.turn_slight_left);
      case NavigationInstructionsType.turnLeft:
        directionIcon = getIconWidget(Icons.turn_left);
      case NavigationInstructionsType.turnSharpLeft:
        directionIcon = getIconWidget(Icons.turn_sharp_left);
      case NavigationInstructionsType.keepLeft:
        directionIcon = getKeepMovingWidget();

      case NavigationInstructionsType.turnSlightRight:
        directionIcon = getIconWidget(Icons.turn_slight_right);
      case NavigationInstructionsType.turnRight:
        directionIcon = getIconWidget(Icons.turn_right);
      case NavigationInstructionsType.turnSharpRight:
        directionIcon = getIconWidget(Icons.turn_sharp_right);
      case NavigationInstructionsType.keepRight:
        directionIcon = getKeepMovingWidget(isKeepMovingLeft: false);
      default:
        directionIcon = getIconWidget(Icons.swipe_up_alt_outlined);
    }

    return directionIcon;
  }
}

Widget getKeepMovingWidget({bool isKeepMovingLeft = true}) {
  if (isKeepMovingLeft) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 12),
          child: Icon(
            Icons.turn_slight_right,
            color: Colors.grey.shade400,
            size: 35,
          ),
        ),
        Icon(
          Icons.turn_slight_left_outlined,
          color: Colors.grey.shade700,
          size: 45,
        ),
      ],
    );
  }

  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Icon(
          Icons.turn_slight_left,
          color: Colors.grey.shade400,
          size: 35,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Icon(
          Icons.turn_slight_right_outlined,
          color: Colors.grey.shade700,
          size: 45,
        ),
      ),
    ],
  );
}

Widget getIconWidget(IconData icon, {Color? iconColor, double size = 45}) {
  return Padding(
    padding: const EdgeInsets.only(left: 2),
    child: Icon(
      icon,
      color: iconColor ?? Colors.grey.shade700,
      size: size,
    ),
  );
}
