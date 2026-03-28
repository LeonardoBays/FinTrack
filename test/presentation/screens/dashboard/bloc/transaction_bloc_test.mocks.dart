import 'package:fintrack/domain/usecases/add_transaction.dart';
import 'package:fintrack/domain/usecases/delete_transaction.dart';
import 'package:fintrack/domain/usecases/get_balance.dart';
import 'package:fintrack/domain/usecases/get_transactions.dart';
import 'package:mocktail/mocktail.dart';

/// A class which mocks [GetTransactions].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTransactions extends Mock implements GetTransactions {}

/// A class which mocks [AddTransaction].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTransaction extends Mock implements AddTransaction {}

/// A class which mocks [DeleteTransaction].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTransaction extends Mock implements DeleteTransaction {}

/// A class which mocks [GetBalance].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetBalance extends Mock implements GetBalance {}
