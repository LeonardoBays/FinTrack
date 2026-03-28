import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:fintrack/domain/usecases/delete_transaction.dart';

import 'delete_transaction_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  late DeleteTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = DeleteTransaction(mockRepository);
  });

  test('DeleteTransaction UseCase deve chamar repository.deleteTransaction com o ID correto', () async {
    // Arrange
    const tId = '123';
    when(mockRepository.deleteTransaction(any)).thenAnswer((_) async {});

    // Act
    await useCase(tId);

    // Assert
    verify(mockRepository.deleteTransaction(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('DeleteTransaction UseCase deve propagar exceção se o repositório falhar', () async {
    // Arrange
    const tId = '123';
    when(mockRepository.deleteTransaction(any)).thenThrow(Exception('Erro no BD'));

    // Act
    final call = useCase;

    // Assert
    expect(() => call(tId), throwsException);
    verify(mockRepository.deleteTransaction(tId)).called(1);
  });
}
