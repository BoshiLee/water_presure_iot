import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:water_pressure_iot/constants/colors.dart';
import 'package:water_pressure_iot/models/device.dart';
import 'package:water_pressure_iot/screens/register/wigets/register_device_form.dart';

typedef OnDeviceChange = Function(int index, Device value);

class RegisterDevicePage extends StatefulWidget {
  final List<Device> devices;
  final OnDeviceChange onDeviceChange;

  const RegisterDevicePage({
    super.key,
    required this.onDeviceChange,
    required this.devices,
  });

  @override
  State<RegisterDevicePage> createState() => _RegisterDevicePageState();
}

class _RegisterDevicePageState extends State<RegisterDevicePage> {
  late int _currentPage;
  late PageController _controller;
  late List<Device> _devices;

  @override
  void initState() {
    _devices = widget.devices;
    _currentPage = 0;
    _controller = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            onPageChanged: (value) => setState(
              () => _currentPage = value,
            ),
            controller: _controller,
            itemCount: _devices.length,
            itemBuilder: (context, index) => RegisterDeviceForm(
              initDevice: _devices[index],
              onChanged: (Device value) {
                _devices[index] = value;
                widget.onDeviceChange(index, value);
              },
            ),
          ),
        ),
        if (_devices.length > 1)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: PageViewDotIndicator(
              currentItem: _currentPage,
              count: _devices.length,
              unselectedColor: Colors.black26,
              selectedColor: itri_blue,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.circle,
              onItemClicked: (index) {
                _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
      ],
    );
  }
}
