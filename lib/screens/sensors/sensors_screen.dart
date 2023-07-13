import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_card.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fd),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) => Container(
          height: 300,
          child: Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                child: DashBoardCard(
                  margin: const EdgeInsets.only(left: 16, right: 8, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Latest Pressure Value:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: '0',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 105,
                                fontFamily: 'Roboto',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'kgf',
                                  style: TextStyle(
                                    fontSize: 26,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                            strutStyle: StrutStyle(
                              fontFamily: 'Roboto',
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Sensor $index ',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: DashBoardCard(
                  margin: const EdgeInsets.only(left: 8, right: 16, bottom: 16),
                  child: Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
