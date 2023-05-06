import 'package:intl/intl.dart';

class Utils {

  static String dateFormat(String date){
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy HH:mm').format(dateTime);
  }

}