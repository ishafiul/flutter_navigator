import 'package:flutter/material.dart';
import 'package:flutter_navigator/src/providers/instruction_controller_provider.dart';
import 'package:flutter_navigator/src/utils/calculator_utils.dart';
import 'package:flutter_navigator/src/utils/sign.dart';

/// Gives Instruction info which appears at the top when the user is navigating
/// This also includes the simulation
///
class InstructionInfo extends StatelessWidget {
  const InstructionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // get navigation instruction controller class
    final instructionInfoController =
        NavigationInstructionProvider.of(context)!;

    // Below widget gets rebuilt whenever there is change in the controller [instructionInfoController]
    return ListenableBuilder(
      listenable: instructionInfoController,
      builder: (context, child) {
        final instruction = instructionInfoController.instruction;
        return Positioned(
          top: 24,
          right: 24,
          left: 24,
          child: (instruction?.instruction != null &&
                  instruction!.instruction.isNotEmpty)
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .7,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          leading: NavigationInstructionsType
                              .getDirectionIconByInstructionType(
                            instructionType: instruction.type,
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                CalculatorUtils.calculateTime(
                                  miliSeconds: instruction.duration,
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            CalculatorUtils.calculateDistance(
                              distanceInMeter: instruction.distance,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                              height: 1.5,
                            ),
                          ),
                          subtitle: Text(
                            instruction.instruction,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Then"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
