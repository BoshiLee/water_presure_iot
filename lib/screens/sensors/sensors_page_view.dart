import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/sensor_data_table.dart';
import 'package:water_pressure_iot/screens/sensors/sensors_gird_view.dart';

class SensorsTabbedPage extends StatefulWidget {
  final double gridItemWidth;
  final double gridItemHeight;
  final List<Sensor> sensors;

  const SensorsTabbedPage({
    super.key,
    required this.gridItemWidth,
    required this.gridItemHeight,
    required this.sensors,
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
    _tabController = TabController(vsync: this, length: _tabs.length);
    _tabViews = [
      BlocBuilder<SensorsDataTableCubit, SensorsDataTableState>(
        builder: (context, state) {
          if (state is SensorsDataTableLoading) {
            return const Center(
              child: Column(
                children: [
                  Text('數據載入中...'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (state is SensorsDataTableLoaded) {
            return SensorDataTable(
              sensors: state.sensors,
              dataTable: state.dataTable,
            );
          }
          return const Center(
            child: Text('無法獲取壓力計資料'),
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
