import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  static DateTime parseToLocal(String formattedString) =>
      DateTime.parse(formattedString).toLocal();

  String toDateString({required String formatString}) =>
      DateFormat(formatString, 'zh_TW').format(this);

  String getVerboseDateTimeRepresentation({bool withDate = true}) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = this.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      // return localizations.translate('dateFormatter_just_now');
      return '剛剛';
    }

    String hourMinute = DateFormat('jm').format(this);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return hourMinute;
    }

    DateTime yesterday = now.subtract(Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return '昨天';
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = localDateTime.toDateString(formatString: 'E');
      return '$weekday';
    }

    return this.toDateString(formatString: withDate ? 'MM/dd' : 'HH:mm');
  }

  int? get toBirthday {
    DateTime now = DateTime.now();
    DateTime today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    int yearDiff = today.year - this.year;
    if (yearDiff <= 0) return null;

    DateTime _date = DateTime(
      this.year + yearDiff,
      this.month,
      this.day,
    );

    if (_date.compareTo(today) > 0) {
      yearDiff--;
    }

    return yearDiff;
  }
}

extension DateTimeHelper on String {
  DateTime toDateTime(String format) => DateFormat(format).parse(this);
}
