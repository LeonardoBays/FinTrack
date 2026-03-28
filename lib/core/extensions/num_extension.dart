import 'package:intl/intl.dart';

extension NumExtension on num {
  String get toCurrency {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(this);
  }
}
final dateFormat = DateFormat("dd 'de' MMMM 'de' yyyy", 'pt_BR');