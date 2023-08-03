import 'flavor.dart';

class Config {
  static Flavor appFlavor = Flavor.LOCALHOST;

  static String get host {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'prod.nbiot.itri.org.tw';
      case Flavor.DEVELOPMENT:
        return '192.168.1.169:5000';
      case Flavor.LOCALHOST:
        return '127.0.0.1:5000';

      case Flavor.UNDETERMINED:
        return 'dev.hearting.online';
    }
  }

  static String get socket {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'prod.io.hearting.online';
      case Flavor.DEVELOPMENT:
        return 'dev.io.hearting.online';
      case Flavor.LOCALHOST:
        return 'dev.io.hearting.online';
      case Flavor.UNDETERMINED:
        return 'dev.io.hearting.online';
    }
  }

  static String get serviceStatus {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'service-status.hearting.online';
      case Flavor.DEVELOPMENT:
        return 'dev.service-status.hearting.online';
      case Flavor.LOCALHOST:
        return 'dev.service-status.hearting.online';
      case Flavor.UNDETERMINED:
        return 'service-status.hearting.online';
    }
  }

  static String get facebookAppId {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return '1756851604493631';
      case Flavor.DEVELOPMENT:
        return '410346270131917';
      case Flavor.LOCALHOST:
        return '410346270131917';
      case Flavor.UNDETERMINED:
        return '410346270131917';
    }
  }

  static String get lineChannelId {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return '1654358367';
      case Flavor.DEVELOPMENT:
        return '1654347570';
      case Flavor.LOCALHOST:
        return '1654347570';
      case Flavor.UNDETERMINED:
        return '1654347570';
    }
  }

  static String get appleSignInClientId {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'com.oun.hearting.signin';
      case Flavor.DEVELOPMENT:
        return 'com.oun.hearting.signin.dev';
      case Flavor.LOCALHOST:
        return 'com.oun.hearting.signin.dev';
      case Flavor.UNDETERMINED:
        return 'com.oun.hearting.signin.dev';
    }
  }

  static String get iapStoreEnv {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'production';
      case Flavor.DEVELOPMENT:
        return 'sandbox';
      case Flavor.LOCALHOST:
        return 'sandbox';
      case Flavor.UNDETERMINED:
        return 'sandbox';
    }
  }
}

void applyConfig(Flavor flavor) {
  Config.appFlavor = flavor;
}
