import 'package:flutter/material.dart';
import 'package:flutter_navigator/src/providers/map_controller_provider.dart';

class SimulateButton extends StatefulWidget {
  const SimulateButton({
    super.key,
  });

  @override
  State<SimulateButton> createState() => _SimulateButtonState();
}

class _SimulateButtonState extends State<SimulateButton> {
  bool isSimulateRouting = false;

  @override
  Widget build(BuildContext context) {
    final mapController = MapControllerProvider.of(context);
    return ElevatedButton(
        onPressed: () {
          isSimulateRouting = !isSimulateRouting;
          mapController.simulateRouting();
        },
        child: const Text("Simulate"));
  }
}
