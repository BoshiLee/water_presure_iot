import 'package:water_pressure_iot/utils/date_helper.dart';

class Account {
  String? email;
  DateTime? expiration;
  int? id;
  String? name;
  String? token;

  Account({this.email, this.expiration, this.id, this.name, this.token});

  Account.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    token = json['token'];
    expiration = json['expiration'] != null
        ? DateHelper.parseToLocal(json['expiration'])
        : null;
  }
}
