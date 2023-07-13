import 'package:flutter/material.dart';

import 'app.dart';
import 'config.dart';
import 'flavor.dart';

void main() {
  applyConfig(Flavor.LOCALHOST);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
