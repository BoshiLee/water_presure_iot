import 'package:flutter/material.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/icons/nbiot_icons.dart';
import 'package:water_pressure_iot/models/sensor.dart';
import 'package:water_pressure_iot/screens/sensors/chart/sensor_chart_table.dart';
import 'package:water_pressure_iot/screens/sensors/table/sersor_tablview.dart';

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
      const SensorTableView(),
      SensorChartTable(
        sensors: widget.sensors,
      ),
      // SensorsGridview(
      //   sensors: widget.sensors,
      //   gridItemWidth: widget.gridItemWidth,
      //   gridItemHeight: widget.gridItemHeight,
      // )
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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
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
