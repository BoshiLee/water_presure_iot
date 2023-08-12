import 'package:flutter/material.dart';
import 'package:water_pressure_iot/models/device.dart';

import 'title_input_field.dart';

class RegisterDeviceForm extends StatefulWidget {
  final Device initDevice;
  final ValueChanged<Device> onChanged;

  const RegisterDeviceForm({
    super.key,
    required this.initDevice,
    required this.onChanged,
  });

  @override
  State<RegisterDeviceForm> createState() => _RegisterDeviceFormState();
}

class _RegisterDeviceFormState extends State<RegisterDeviceForm> {
  late Device device;

  @override
  void initState() {
    device = widget.initDevice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '請輸入設備資訊',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TitleInputField(
            initialValue: device.name,
            title: '輸入設備名稱',
            hintText: 'Device Name',
            onChanged: (value) {
              device = device.copyWith(name: value);
              widget.onChanged(device);
            },
          ),
          TitleInputField(
            initialValue: device.description,
            title: '輸入設備描述',
            hintText: 'Device Description',
            onChanged: (value) {
              device = device.copyWith(description: value);
              widget.onChanged(device);
            },
          ),
          TitleInputField(
            initialValue: device.uri,
            title: '輸入設備 uri',
            hintText: 'Device uri',
            onChanged: (value) {
              device = device.copyWith(uri: value);
              widget.onChanged(device);
            },
          ),
          TitleInputField(
            initialValue: device.deviceType,
            title: '輸入設備類型',
            hintText: 'Device Type',
            onChanged: (value) {
              device = device.copyWith(type: value);
              widget.onChanged(device);
            },
          ),
          // TitleInputField(
          //   title: '輸入設備代碼',
          //   hintText: 'Device number',
          //   onChanged: (value) {},
          // ),
          TitleInputField(
            initialValue: device.deviceKey,
            title: '輸入設備金鑰',
            hintText: 'Device Key',
            obscureText: true,
            onChanged: (value) {
              device = device.copyWith(deviceKey: value);
              widget.onChanged(device);
            },
          ),
        ],
      ),
    );
  }
}
