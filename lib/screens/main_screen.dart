import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/screens/sensors/sensors_screen.dart';
import 'package:water_pressure_iot/screens/widgets/side_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _key = GlobalKey<ScaffoldState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final SidebarXController controller = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  backgroundColor: canvasColor,
                  title: Text(_getTitleByIndex(_controller.selectedIndex)),
                  leading: IconButton(
                    onPressed: () {
                      // if (!Platform.isAndroid && !Platform.isIOS) {
                      //   _controller.setExtended(true);
                      // }
                      _key.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                )
              : null,
          drawer: Sidebar(controller: _controller),
          body: Row(
            children: [
              if (!isSmallScreen) Sidebar(controller: _controller),
              Expanded(
                child: Center(
                  child: SensorsScreen(
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}
