import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/cubits/sensors/data_query_counter_cubit.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/chart/sensor_chart_table.dart';
import 'package:water_pressure_iot/screens/sensors/table/sensor_data_table.dart';
import 'package:water_pressure_iot/utils/sava_file_html.dart';

import '../../cubits/sensors/sensors_cubit.dart';

class SensorsPageView extends StatefulWidget {
  final double gridItemWidth;
  final double gridItemHeight;
  final List<Sensor> sensors;
  final bool isLoading;

  const SensorsPageView({
    super.key,
    required this.gridItemWidth,
    required this.gridItemHeight,
    required this.sensors,
    this.isLoading = false,
  });

  @override
  State<SensorsPageView> createState() => _SensorsPageViewState();
}

class _SensorsPageViewState extends State<SensorsPageView>
    with SingleTickerProviderStateMixin {
  static const List<Tab> _tabs = <Tab>[
    Tab(text: '統計表'),
    Tab(text: '圖表'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool canNotPress(BuildContext context, SensorsDataTableState state) {
    return state is SensorsDataExportLoading ||
        state is SensorsDataTableLoading ||
        state is SensorsDataTableError ||
        state is SensorsDataTablePolling ||
        state.dataTable == null;
  }

  void syncData(
    BuildContext context,
    int counter,
  ) {
    final resetValue = context.read<DataQueryCounterCubit>().resetValue;
    if (counter > 0 && counter < resetValue) {
      context.read<DataQueryCounterCubit>().pause();
      return;
    }
    context.read<DataQueryCounterCubit>().counting();
  }

  List<Widget> _tabViews(BuildContext context, SensorsDataTableState state) {
    if (state is SensorsDataTableLoading || state is SensorsDataTableError) {
      return [];
    }
    return [
      SensorDataTable(
        dataHeader: state.dataHeader!,
        dataTable: state.dataTable!,
      ),
      SensorChartTable(
        sensors: context.read<SensorsDataTableCubit>().sensors,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: itri_blue,
        toolbarHeight: 120,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Nbiot.itri_logo,
              size: 60,
              color: Colors.white,
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              '壓力計顯示系統',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: BlocConsumer<SensorsDataTableCubit, SensorsDataTableState>(
        buildWhen: (previous, current) {
          return current is SensorsDataTableLoaded ||
              current is SensorsDataTablePolling ||
              current is SensorsDataTablePollingUpdated ||
              current is SensorsDataTableLoading;
        },
        listener: (context, state) {
          if (state is SensorsDataTableError) {
            BotToast.showText(text: state.message);
          }
          if (state is SensorsDataExportLoading) {
            BotToast.showLoading();
          }
          if (state is SensorsDataExportCSVLoaded) {
            BotToast.closeAllLoading();
            webDownloadFile(state.csvString, state.fileName);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Exported to CSV'),
              ),
            );
          }
          if (state is SensorsDataExportExcelLoaded) {
            BotToast.closeAllLoading();
            webDownloadFile(state.excel, state.fileName);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Exported to Excel'),
              ),
            );
          }
          if (state is SensorsDataTableLoaded) {
            BotToast.closeAllLoading();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('數據載入完成'),
              ),
            );
          }
          if (state is SensorsDataTablePolling) {
            context.read<DataQueryCounterCubit>().pause();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('與中華電信更新數據中...'),
              ),
            );
          }
          if (state is SensorsDataTablePollingUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('數據更新完成 ${state.lastUpdated}'),
              ),
            );
            context.read<DataQueryCounterCubit>().resume();
          }
        },
        builder: (context, tableState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: canNotPress(context, tableState)
                          ? null
                          : context
                              .read<SensorsDataTableCubit>()
                              .generateCsvFile,
                      child: const Text('匯出 CSV'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: canNotPress(context, tableState)
                          ? null
                          : context
                              .read<SensorsDataTableCubit>()
                              .generateExcelFile,
                      child: const Text('匯出 Excel'),
                    ),
                    Expanded(child: Container()),
                    BlocConsumer<DataQueryCounterCubit, int>(
                      listener: (context, state) {
                        if (state == 0) {
                          context.read<SensorsCubit>().refresh();
                        }
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Text(
                              '下次同步時間: ${state.toString()} 秒',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: canNotPress(context, tableState)
                                  ? null
                                  : () => syncData(
                                        context,
                                        state,
                                      ),
                              child: Text(
                                context.read<DataQueryCounterCubit>().message,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (tableState is SensorsDataTableLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (tableState is SensorsDataTableError)
                Center(
                  child: Text(tableState.message),
                ),
              if (tableState is SensorsDataTablePolling) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabViews(context, tableState),
                  ),
                ),
              ],
              if (tableState is SensorsDataTableLoaded ||
                  tableState is SensorsDataTablePollingUpdated)
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _tabViews(context, tableState),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
