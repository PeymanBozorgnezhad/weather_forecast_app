import 'package:intl/intl.dart';

class Util {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, MMM d, y, hh:mm:aa').format(dateTime);
  }
}
