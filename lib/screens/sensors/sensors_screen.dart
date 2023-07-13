import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/cubits/sensors_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_card.dart';
import 'package:water_pressure_iot/screens/sensors/dashboard_value_card.dart';
import 'package:water_pressure_iot/screens/widgets/static_pagination_list_view.dart';

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
      body: BlocBuilder<SensorsCubit, SensorsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async =>
                await context.read<SensorsCubit>().fetchSensors(),
            child: StaticPaginationListView(
              isLoading: state is SensorsLoading,
              itemCount: context.read<SensorsCubit>().sensors.length,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => SizedBox(
                height: 300,
                child: Row(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: DashboardValueCard(
                        sensor: context.read<SensorsCubit>().sensors[index],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: DashBoardCard(
                        margin: const EdgeInsets.only(
                            left: 8, right: 16, bottom: 16),
                        child: Container(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
