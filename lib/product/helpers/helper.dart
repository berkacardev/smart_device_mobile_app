import 'package:intl/intl.dart';
import 'package:smart_device_mobile_app/product/constants/lang/local_keys_tr.dart';

abstract class Helper {
  static String getTimeAgo(DateTime dateTime) {
    final Duration diff = DateTime.now().difference(dateTime);

    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} ${LocalKeysTr.YEAR_AGO}';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} ${LocalKeysTr.MONT_AGO}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} ${LocalKeysTr.DAY_AGO}';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ${LocalKeysTr.HOUR_AGO}';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} ${LocalKeysTr.MINUTE_AGO}';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds} ${LocalKeysTr.SECOND_AGO}';
    } else {
      return LocalKeysTr.JUST_NOW;
    }
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }
}
