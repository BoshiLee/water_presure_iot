import 'package:water_pressure_iot/models/sensor_data.dart';

class ChartData {
  DateTime? date;
  int? pressure;

  ChartData({this.date, this.pressure});
}

List<ChartData> convertSensorDataToChartData(List<SensorData>? sensorData) {
  List<ChartData> chartDataList = [];
  if (sensorData != null) {
    for (var data in sensorData) {
      chartDataList.add(
        ChartData(
          date: data.timestamp,
          pressure: data.pressure,
        ),
      );
    }
  }
  return chartDataList;
}
