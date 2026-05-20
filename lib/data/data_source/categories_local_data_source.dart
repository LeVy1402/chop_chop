import 'dart:convert';
import 'package:chop_chop/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';

abstract class CategoriesLocalDataSource {
  /// Get the cached [List<CategoryModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CategoryModel>> getLastCategories();

  Future<void> cacheCategories(List<CategoryModel> categories);
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  static const cachedCategoriesKey = 'CACHED_CATEGORIES';

  final SharedPreferences sharedPreferences;

  CategoriesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    await sharedPreferences.setString(
      cachedCategoriesKey,
      json.encode(categories.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<List<CategoryModel>> getLastCategories() async {
    final jsonString = sharedPreferences.getString(cachedCategoriesKey);
    if (jsonString == null) {
      throw CacheException();
    }
    final decoded = json.decode(jsonString) as List<dynamic>;

    return decoded
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
