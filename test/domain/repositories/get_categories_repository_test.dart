import 'package:chop_chop/domain/entities/category.dart';
import 'package:chop_chop/domain/repositories/get_categories_repository.dart';
import 'package:chop_chop/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Tạo Mock class bằng mockito
@GenerateMocks([GetCategoriesRepository])
import 'get_categories_repository_test.mocks.dart';

void main() {
  provideDummy<Result<List<Category>>>(const Success<List<Category>>([]));

  late MockGetCategoriesRepository mockGetCategoriesRepository;

  setUp(() {
    mockGetCategoriesRepository = MockGetCategoriesRepository();
  });

  group('getCategories', () {
    const tCategories = [
      Category(name: 'Pizza', imageUrl: 'pizza_url'),
      Category(name: 'Burger', imageUrl: 'burger_url'),
    ];

    test(
      'should return Success with list of categories when the call is successful',
      () async {
        // Arrange
        when(
          mockGetCategoriesRepository.getCategories(),
        ).thenAnswer((_) async => const Success(tCategories));

        // Act
        final result = await mockGetCategoriesRepository.getCategories();

        // Assert
        expect(result, isA<Success<List<Category>>>());
        expect((result as Success).value, tCategories);
        verify(mockGetCategoriesRepository.getCategories());
        verifyNoMoreInteractions(mockGetCategoriesRepository);
      },
    );

    test('should return Failure when the call is unsuccessful', () async {
      // Arrange
      const errorMessage = 'Server Error';
      when(
        mockGetCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Failure(errorMessage));

      // Act
      final result = await mockGetCategoriesRepository.getCategories();

      // Assert
      expect(result, isA<Failure<List<Category>>>());
      expect((result as Failure).message, errorMessage);
      verify(mockGetCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockGetCategoriesRepository);
    });
  });
}
