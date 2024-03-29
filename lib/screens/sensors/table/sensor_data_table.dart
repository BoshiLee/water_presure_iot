import 'package:flutter/material.dart';

class SensorDataTable extends StatelessWidget {
  final List<String> dataHeader;
  final List<List<String>> dataTable;
  final VoidCallback? exportCSV;
  final VoidCallback? exportExcel;
  final VoidCallback? syncData;

  const SensorDataTable({
    super.key,
    required this.dataHeader,
    required this.dataTable,
    this.exportExcel,
    this.exportCSV,
    this.syncData,
  });

  List<Widget> _buildRows(List<String> dataRow) {
    return dataRow
        .map(
          (e) => Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 140,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Text(e),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (dataHeader.isEmpty) {
      return const Center(
        child: Text('目前尚無壓力計資料'),
      );
    }
    // 取得所有sensor的sensorData，並合併成一個列表
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildRows(
              dataHeader,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemExtent: 50,
            itemCount: dataTable.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildRows(dataTable[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
