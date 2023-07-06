import 'package:flutter/material.dart';

import 'app.dart';
import 'config.dart';
import 'flavor.dart';

void main() {
  applyConfig(Flavor.DEVELOPMENT);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}


