import 'package:shared_preferences/shared_preferences.dart';

class AuthenticatorConfiguration {
  static late SharedPreferences _prefs;

  static Future<void> loadConfiguration() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveConfiguration(
      {required String gateType, required String gateStationId}) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('gateType', gateType);
    _prefs.setString('gateStationId', gateStationId);
  }

  String get gateType => _prefs.getString('gateType') ?? 'entrance';
  String get gateStationId => _prefs.getString('gateStationId') ?? 'S001';
  bool get isGateEntrance => gateType == 'entrance';
  bool get isGateExit => gateType == 'exit';
  static void setGateType(String value) => _prefs.setString('gateType', value);
  static void setGateStationId(String value) =>
      _prefs.setString('gateStationId', value);
}
