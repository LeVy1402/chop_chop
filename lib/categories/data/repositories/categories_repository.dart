import 'package:chop_chop/categories/domain/entities/category.dart';
import 'package:chop_chop/utils/result.dart';

abstract class CategoriesRepository {
  Future<Result<List<Category>>> getCategories();
}
