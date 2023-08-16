import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/chart/sensors_gird_view.dart';
import 'package:water_pressure_iot/screens/sensors/table/sensor_data_table.dart';
import 'package:water_pressure_iot/utils/sava_file_html.dart';

class SensorsTabbedPage extends StatefulWidget {
  final double gridItemWidth;
  final double gridItemHeight;
  final List<Sensor> sensors;
  final bool isLoading;

  const SensorsTabbedPage({
    super.key,
    required this.gridItemWidth,
    required this.gridItemHeight,
    required this.sensors,
    this.isLoading = false,
  });

  @override
  State<SensorsTabbedPage> createState() => _SensorsTabbedPageState();
}

class _SensorsTabbedPageState extends State<SensorsTabbedPage>
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
    _tabViews = [
      BlocConsumer<SensorsDataTableCubit, SensorsDataTableState>(
        buildWhen: (previous, current) {
          return current is SensorsDataTableLoaded ||
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('數據載入完成'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SensorsDataTableLoading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.0),
                Text('數據載入中...'),
              ],
            );
          }
          if (state.dataHeader == null || state.dataTable == null) {
            return const Center(
              child: Text('無法獲取壓力計資料'),
            );
          }
          return SensorDataTable(
            dataHeader: state.dataHeader!,
            dataTable: state.dataTable!,
            exportCSV: state is SensorsDataExportLoading
                ? null
                : context.read<SensorsDataTableCubit>().generateCsvFile,
            exportExcel: state is SensorsDataExportLoading
                ? null
                : context.read<SensorsDataTableCubit>().generateExcelFile,
          );
        },
      ),
      SensorsGridview(
        sensors: widget.sensors,
        gridItemWidth: widget.gridItemWidth,
        gridItemHeight: widget.gridItemHeight,
      )
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late List<Widget> _tabViews;

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
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
}
