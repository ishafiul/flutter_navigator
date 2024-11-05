import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/utils/calculator_utils.dart';
import 'package:flutter_navigator/src/utils/sign.dart';

class NavigationInfoItemUi extends StatelessWidget {
  /// Creates [NavigationInfoItemUi] instance
  ///
  const NavigationInfoItemUi({
    super.key,
    required this.index,
    required this.instruction,
  });

  /// [index] integer value
  ///
  final int index;

  /// [Instruction] instance
  ///
  final InstructionStep instruction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: index != 0 && instruction.type == 0
              ? NavigationInstructionsType.getDirectionIconByInstructionType(
                  instructionType: index == 0 ? 10 : instruction.type,
                )
              : NavigationInstructionsType.getDirectionIconByInstructionType(
                  instructionType: index == 0 ? 10 : instruction.type,
                ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                CalculatorUtils.calculateDistance(
                  distanceInMeter: instruction.distance,
                ),
              ),
              Text(
                CalculatorUtils.calculateTime(
                    miliSeconds: instruction.duration),
              ),
            ],
          ),
          title: Text(
            instruction.instruction,
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: CupertinoColors.inactiveGray,
        ),
      ],
    );
  }
}
