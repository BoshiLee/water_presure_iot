enum RegisterProgress {
  unregistered,
  registered,
  registeredProject,
  registeredProjectAndDevices
}

extension RegisterProgressExtension on RegisterProgress {
  String? get rawValue {
    switch (this) {
      case RegisterProgress.unregistered:
        return 'unregistered';
      case RegisterProgress.registered:
        return 'registered';
      case RegisterProgress.registeredProject:
        return 'registeredProject';
      case RegisterProgress.registeredProjectAndDevices:
        return 'registeredProjectAndDevices';
      default:
        return null;
    }
  }

  static RegisterProgress? fromRawValue(String? rawValue) {
    switch (rawValue) {
      case 'unregistered':
        return RegisterProgress.unregistered;
      case 'registered':
        return RegisterProgress.registered;
      case 'registeredProject':
        return RegisterProgress.registeredProject;
      case 'registeredProjectAndDevices':
        return RegisterProgress.registeredProjectAndDevices;
      default:
        return null;
    }
  }
}
