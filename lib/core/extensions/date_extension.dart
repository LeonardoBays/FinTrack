import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get fullDate {
    return DateFormat("dd 'de' MMMM 'de' yyyy", 'pt_BR').format(this);
  }
}
