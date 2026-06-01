import 'package:chop_chop/categories/domain/entities/category.dart';
import 'package:chop_chop/categories/domain/repositories/get_categories_repository.dart';
import 'package:chop_chop/categories/domain/use_cases/get_categories.dart';
import 'package:chop_chop/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_categories_test.mocks.dart';

@GenerateMocks([GetCategoriesRepository])
void main() {
  setUpAll(() {
    provideDummy<Result<List<Category>>>(const Success<List<Category>>([]));
  });

  late GetCategories useCase;
  late MockGetCategoriesRepository mockGetCategoriesRepository;

  setUp(() {
    mockGetCategoriesRepository = MockGetCategoriesRepository();
    useCase = GetCategories(mockGetCategoriesRepository);
  });

  group('GetCategories', () {
    const tCategories = [
      Category(name: 'Pizza', imageUrl: 'pizza_url'),
      Category(name: 'Burger', imageUrl: 'burger_url'),
    ];

    test(
      'should call repository.getCategories() when usecase is called',
      () async {
        // Arrange
        when(
          mockGetCategoriesRepository.getCategories(),
        ).thenAnswer((_) async => const Success(tCategories));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Success<List<Category>>>());
        expect((result as Success).value, tCategories);
        verify(mockGetCategoriesRepository.getCategories()).called(1);
        verifyNoMoreInteractions(mockGetCategoriesRepository);
      },
    );

    test('should return Failure when repository throws error', () async {
      // Arrange
      const errorMessage = 'Failed to fetch categories';
      when(
        mockGetCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Failure(errorMessage));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Failure<List<Category>>>());
      expect((result as Failure).message, errorMessage);
      verify(mockGetCategoriesRepository.getCategories()).called(1);
      verifyNoMoreInteractions(mockGetCategoriesRepository);
    });

    test('should handle empty categories list', () async {
      // Arrange
      const emptyCategories = <Category>[];
      when(
        mockGetCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Success(emptyCategories));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Success<List<Category>>>());
      expect((result as Success).value, isEmpty);
      verify(mockGetCategoriesRepository.getCategories()).called(1);
      verifyNoMoreInteractions(mockGetCategoriesRepository);
    });

    test('should return result from repository without modification', () async {
      // Arrange
      when(
        mockGetCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Success(tCategories));

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, isA<Success<List<Category>>>());
      expect((result as Success).value, equals(tCategories));
    });

    test('should propagate error message from repository', () async {
      // Arrange
      const errorMessage = 'Network error occurred';
      when(
        mockGetCategoriesRepository.getCategories(),
      ).thenAnswer((_) async => const Failure(errorMessage));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Failure<List<Category>>>());
      expect((result as Failure).message, equals(errorMessage));
    });

    test(
      'should call repository getCategories exactly once per usecase call',
      () async {
        // Arrange
        when(
          mockGetCategoriesRepository.getCategories(),
        ).thenAnswer((_) async => const Success(tCategories));

        // Act
        await useCase();

        // Assert
        verify(mockGetCategoriesRepository.getCategories()).called(1);
      },
    );
  });
}
