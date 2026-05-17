import 'dart:convert';

import 'package:chop_chop/core/error/exceptions.dart';
import 'package:chop_chop/data/data_source/categories_local_data_source.dart';
import 'package:chop_chop/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fixtures/fixture_reader.dart';
import 'categories_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late CategoriesLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = CategoriesLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getCategories', () {
    test(
      'should return CategoryListModel from SharedPreferences when there is one in the cache',
      () async {
        final tCategoryModels =
            (json.decode(fixture('categories_cached.json')) as List)
                .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
                .toList();
        // arrange
        when(
          mockSharedPreferences.getString(any),
        ).thenReturn(fixture('categories_cached.json'));
        // act
        final result = await dataSource.getLastCategories();
        // assert
        verify(mockSharedPreferences.getString('CACHED_CATEGORIES'));
        expect(result, equals(tCategoryModels));
      },
    );

    test('should throw a CacheException where there is not cache value', () {
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      final call = dataSource.getLastCategories;
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheCategories', () {
    final tCategoriesModel = [
      CategoryModel(
        name: 'Appetizers',
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      ),
    ];

    test('should call SharePreference to cache the data', () async {
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);
      dataSource.cacheCategories(tCategoriesModel);
      verify(
        mockSharedPreferences.setString(
          'CACHED_CATEGORIES',
          json.encode(tCategoriesModel),
        ),
      );
    });
  });
}
