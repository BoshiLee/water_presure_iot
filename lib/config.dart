import 'package:water_pressure_iot/api/api_versioning.dart';

import 'flavor.dart';

class Config {
  static Flavor appFlavor = Flavor.LOCALHOST;

  static String get host {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'prod.nbiot.itri.org.tw';
      case Flavor.DEVELOPMENT:
        return 'irtik900.asuscomm.com:50';
      case Flavor.LOCALHOST:
        return '127.0.0.1:5000';

      case Flavor.UNDETERMINED:
        return 'dev.hearting.online';
    }
  }

  static String apiVersioning({
    ApiVersioning version = ApiVersioning.v1,
  }) =>
      'api/${version.rawValue}';
}

void applyConfig(Flavor flavor) {
  Config.appFlavor = flavor;
}
