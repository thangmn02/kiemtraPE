import 'package:intl/intl.dart';

import 'constants.dart';

class FormatHelper {
  static String formatMoney(int amount, String currency) {
    if (currency == Constants.currencyUsd) {
      double usd = amount / Constants.usdRate;
      return '${NumberFormat('#,##0.00').format(usd)} USD';
    }
    return '${NumberFormat('#,###').format(amount)} VND';
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static DateTime? parseDate(String text) {
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(text);
    } on FormatException {
      return null;
    }
  }
}
