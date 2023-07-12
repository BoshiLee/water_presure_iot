import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:water_pressure_iot/constants/page_titles.dart';
import 'package:water_pressure_iot/screens/main/main_content_screen.dart';
import 'package:water_pressure_iot/screens/widgets/side_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _key = GlobalKey<ScaffoldState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          appBar: isSmallScreen
              ? AppBar(
                  backgroundColor: const Color(0xD4E5E9),
                  title: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Text(
                        PageTitle.getTitleByIndex(_controller.selectedIndex),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
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
                  child: MainContentScreen(
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
