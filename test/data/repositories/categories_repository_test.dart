import 'package:chop_chop/data/repositories/categories_repository.dart';
import 'package:chop_chop/domain/entities/category.dart';
import 'package:chop_chop/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Tạo Mock class bằng mockito
@GenerateMocks([CategoriesRepository])
import 'categories_repository_test.mocks.dart';

void main() {
  provideDummy<Result<List<Category>>>(const Success<List<Category>>([]));
  late MockCategoriesRepository mockCategoriesRepository;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
  });

  group('CategoriesRepository', () {
    const tCategories = [
      Category(name: 'Pizza', imageUrl: 'pizza_url'),
      Category(name: 'Burger', imageUrl: 'burger_url'),
      Category(name: 'Pasta', imageUrl: 'pasta_url'),
    ];

    test(
      'should return Success with list of categories when the call is successful',
      () async {
        // Arrange
        when(
          mockCategoriesRepository.getCategories(),
        ).thenAnswer((_) async => const Success(tCategories));

        // Act
        final result = await mockCategoriesRepository.getCategories();

        // Assert
        expect(result, isA<Success<List<Category>>>());
        expect((result as Success).value, tCategories);
        expect((result as Success).value.length, 3);
        verify(mockCategoriesRepository.getCategories());
        verifyNoMoreInteractions(mockCategoriesRepository);
      },
    );

    test('should return Failure when the call is unsuccessful', () async {
      // Arrange
      const errorMessage = 'Failed to fetch categories from data source';
      when(
        mockCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Failure(errorMessage));

      // Act
      final result = await mockCategoriesRepository.getCategories();

      // Assert
      expect(result, isA<Failure<List<Category>>>());
      expect((result as Failure).message, errorMessage);
      verify(mockCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    });

    test('should handle empty categories list', () async {
      // Arrange
      const emptyCategories = <Category>[];
      when(
        mockCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Success(emptyCategories));

      // Act
      final result = await mockCategoriesRepository.getCategories();

      // Assert
      expect(result, isA<Success<List<Category>>>());
      expect((result as Success).value, isEmpty);
      expect((result as Success).value.length, 0);
      verify(mockCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    });

    test('should return categories with correct data structure', () async {
      // Arrange
      const singleCategory = [
        Category(name: 'Desserts', imageUrl: 'desserts_url'),
      ];
      when(
        mockCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Success(singleCategory));

      // Act
      final result = await mockCategoriesRepository.getCategories();

      // Assert
      expect(result, isA<Success<List<Category>>>());
      final category = (result as Success).value.first;
      expect(category.name, 'Desserts');
      expect(category.imageUrl, 'desserts_url');
      verify(mockCategoriesRepository.getCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    });
  });
}
