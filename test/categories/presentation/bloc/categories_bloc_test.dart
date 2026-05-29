import 'package:bloc_test/bloc_test.dart';
import 'package:chop_chop/categories/domain/entities/category.dart';
import 'package:chop_chop/categories/domain/use_cases/get_categories.dart';
import 'package:chop_chop/categories/presentation/bloc/categories_bloc.dart';
import 'package:chop_chop/categories/presentation/bloc/categories_event.dart';
import 'package:chop_chop/categories/presentation/bloc/categories_state.dart';
import 'package:chop_chop/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_bloc_test.mocks.dart';

@GenerateMocks([GetCategories])
void main() {
  late MockGetCategories mockGetCategories;
  late CategoriesBloc categoriesBloc;

  setUpAll(() {
    provideDummy<Result<List<Category>>>(const Success<List<Category>>([]));
  });

  setUp(() {
    mockGetCategories = MockGetCategories();
    categoriesBloc = CategoriesBloc(getCategories: mockGetCategories);
  });

  tearDown(() {
    categoriesBloc.close();
  });

  group('CategoriesBloc', () {
    final tCategories = [
      const Category(name: 'Category 1', imageUrl: 'https://example.com/1.jpg'),
      const Category(name: 'Category 2', imageUrl: 'https://example.com/2.jpg'),
    ];

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoading, CategoriesLoaded] when GetCategoriesEvent is added and returns Success',
      build: () {
        when(
          mockGetCategories(),
        ).thenAnswer((_) async => Success<List<Category>>(tCategories));
        return categoriesBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [const CategoriesLoading(), CategoriesLoaded(tCategories)],
      verify: (bloc) {
        verify(mockGetCategories.call()).called(1);
        verifyNoMoreInteractions(mockGetCategories);
      },
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoading, CategoriesEmpty] when GetCategoriesEvent is added and returns Success with empty list',
      build: () {
        when(
          mockGetCategories(),
        ).thenAnswer((_) async => const Success<List<Category>>([]));
        return categoriesBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [const CategoriesLoading(), const CategoriesEmpty()],
      verify: (bloc) {
        verify(mockGetCategories()).called(1);
        verifyNoMoreInteractions(mockGetCategories);
      },
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoading, CategoriesError] when GetCategoriesEvent is added and returns Failure',
      build: () {
        const failureMessage = 'Failed to fetch categories';
        when(mockGetCategories()).thenAnswer(
          (_) async => const Failure<List<Category>>(failureMessage),
        );
        return categoriesBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [
        const CategoriesLoading(),
        const CategoriesError('Failed to fetch categories'),
      ],
      verify: (bloc) {
        verify(mockGetCategories()).called(1);
        verifyNoMoreInteractions(mockGetCategories);
      },
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'emits [CategoriesLoading, CategoriesError] when usecase throws exception',
      build: () {
        when(mockGetCategories()).thenThrow(Exception('Network error'));
        return categoriesBloc;
      },
      act: (bloc) => bloc.add(GetCategoriesEvent()),
      expect: () => [
        const CategoriesLoading(),
        CategoriesError(Exception('Network error').toString()),
      ],
      verify: (_) {
        verify(mockGetCategories()).called(1);
      },
    );
  });
}
