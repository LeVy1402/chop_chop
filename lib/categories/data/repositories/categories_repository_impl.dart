import 'package:chop_chop/categories/data/data_source/categories_remote_data_source.dart';
import 'package:chop_chop/categories/domain/entities/category.dart';
import 'package:chop_chop/core/error/exceptions.dart';
import 'package:chop_chop/utils/result.dart';

import 'categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final categoryListModel = await remoteDataSource.getCategories();
      final categories = categoryListModel.data
          .map((model) => model.toEntity())
          .toList();
      return Success(categories);
    } on ServerException {
      return const Failure('Server error: Failed to fetch categories');
    } catch (e) {
      return Failure('Error: ${e.toString()}');
    }
  }
}
