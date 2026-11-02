import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SettingRepository {
  static const String keyCurrency = 'currency';

  Future<String> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyCurrency) ?? Constants.currencyVnd;
  }

  Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyCurrency, currency);
  }
}
