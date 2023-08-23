import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_pressure_iot/cubits/sensors/sensors_data_table_cubit.dart';
import 'package:water_pressure_iot/screens/sensors/table/sensor_data_table.dart';
import 'package:water_pressure_iot/utils/sava_file_html.dart';

class SensorTableView extends StatelessWidget {
  const SensorTableView({super.key});

  bool canNotPress(BuildContext context, SensorsDataTableState state) {
    return state is SensorsDataExportLoading ||
        state is SensorsDataTableLoading ||
        state is SensorsDataTableError ||
        state.dataTable == null;
  }

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
                    onPressed: canNotPress(context, state)
                        ? null
                        : context.read<SensorsDataTableCubit>().generateCsvFile,
                    child: const Text('匯出 CSV'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: canNotPress(context, state)
                        ? null
                        : context
                            .read<SensorsDataTableCubit>()
                            .generateExcelFile,
                    child: const Text('匯出 Excel'),
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: canNotPress(context, state)
                        ? null
                        : context.read<SensorsDataTableCubit>().syncData,
                    child: const Text('開始同步'),
                  ),
                ],
              ),
            ),
            if (state is SensorsDataTableLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (state.dataTable == null)
              const Center(
                child: Text('無法獲取壓力計資料'),
              ),
            if (state is SensorsDataTableError)
              Center(
                child: Text(state.message),
              ),
            if (state is SensorsDataTableLoaded)
              Expanded(
                child: SensorDataTable(
                  dataHeader: state.dataHeader,
                  dataTable: state.dataTable,
                ),
              ),
          ],
        );
      },
    );
  }
}
