import 'package:chop_chop/domain/entities/category.dart';
import 'package:chop_chop/utils/result.dart';

abstract class GetCategoriesRepository {
  Future<Result<List<Category>>> getCategories();
}
