enum RegisterProgress {
  registeredUser,
  registeredProject,
}

extension RegisterProgressExtension on RegisterProgress {
  String? get rawValue {
    switch (this) {
      case RegisterProgress.registeredUser:
        return 'registeredUser';
      case RegisterProgress.registeredProject:
        return 'registeredProject';
      default:
        return null;
    }
  }

  static RegisterProgress? fromRawValue(String? rawValue) {
    switch (rawValue) {
      case 'registeredUser':
        return RegisterProgress.registeredUser;
      case 'registeredProject':
        return RegisterProgress.registeredProject;
      default:
        return null;
    }
  }
}
