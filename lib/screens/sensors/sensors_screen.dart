import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/cubits/sensors/data_query_counter_cubit.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_cubit.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/sensors_page_view.dart';
import 'package:water_pressure_iot/screens/widgets/custom_loading_widget.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gridItemWidth = screenWidth / 2;
    final gridItemHeight = (screenHeight) / 1.75;
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fd),
      body: BlocConsumer<SensorsCubit, SensorsState>(
        buildWhen: (previous, current) =>
            current is SensorsLoaded || current is SensorsLoaded,
        listener: (context, state) {
          if (state is SensorsError) {
            BotToast.showText(text: state.message);
          }
          if (state is SensorsLoaded) {
            BotToast.closeAllLoading();
          }
          if (state is SensorsLoading) {
            BotToast.showCustomLoading(
              toastBuilder: (_) {
                return const CustomLoadingWidget(
                  message: '壓力計資料讀取中...',
                );
              },
            );
          }
        },
        builder: (ctx, state) {
          if (state is SensorsLoading) {
            return const CustomLoadingWidget(
              message: '壓力計資料讀取中...',
            );
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SensorsDataTableCubit(
                  sensors: context.read<SensorsCubit>().sensors,
                ),
              ),
              BlocProvider(
                create: (context) => DataQueryCounterCubit(resetValue: 10),
              ),
            ],
            child: SensorsTabbedPage(
              sensors: context.read<SensorsCubit>().sensors,
              gridItemWidth: gridItemWidth,
              gridItemHeight: gridItemHeight,
              isLoading: state is SensorsLoading,
            ),
          );
        },
      ),
    );
  }
}
