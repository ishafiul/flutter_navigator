import 'package:flutter/material.dart';
import 'package:flutter_navigator/src/model/open_route_service.dart';
import 'package:flutter_navigator/src/presentation/widgets/navigation_info_item_widget.dart';
import 'package:flutter_navigator/src/presentation/widgets/simulate_btn_widget.dart';
import 'package:flutter_navigator/src/providers/user_speed_notifier_provider.dart';
import 'package:flutter_navigator/src/utils/calculator_utils.dart';

class NavigationInfoUi extends StatelessWidget {
  /// Creates [NavigationInfoUi] instance
  ///
  const NavigationInfoUi({
    super.key,
    required this.directionRouteResponse,
  });

  /// [DirectionRouteResponse] instance
  ///
  final OpenrouteserviceResponse directionRouteResponse;

  @override
  Widget build(BuildContext context) {
    final speedNotifier = UserSpeedProvider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      color: Colors.white,
      margin: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Distance : ${CalculatorUtils.calculateDistance(
                              distanceInMeter: directionRouteResponse.features
                                  .first.properties.segments.first.distance,
                            )}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'Time : ${CalculatorUtils.calculateTime(
                              miliSeconds: directionRouteResponse.features.first
                                  .properties.segments.first.duration,
                            )}',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // listener to update the value of the speed
                        ListenableBuilder(
                          listenable: speedNotifier,
                          builder: (context, child) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8,
                                left: 20,
                              ),
                              child: Text(
                                'Speed : ${speedNotifier.speed.toString()}',
                              ),
                            );
                          },
                        ),

                        // Obx((){
                        //   // List<double> list = navigationController.distanceBtnCOOrds;
                        //   return Padding(padding: const EdgeInsets.only(bottom: 8.0, right: 20.0),
                        //   child: Text('Distance: ${navigationController.distanceBtnCOOrds.value}', style: CustomAppStyle.headline6(context),),);
                        // }),

                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: SimulateButton(),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: directionRouteResponse
                      .features.first.properties.segments.first.steps.length,
                  itemBuilder: (buildContext, index) {
                    return NavigationInfoItemUi(
                      index: index,
                      instruction: directionRouteResponse.features.first
                          .properties.segments.first.steps[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
