import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/table/sensor_data_table.dart';
import 'package:water_pressure_iot/utils/sava_file_html.dart';

class SensorTableView extends StatelessWidget {
  const SensorTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorsDataTableCubit, SensorsDataTableState>(
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
    );
  }
}
