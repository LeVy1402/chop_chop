import 'package:chop_chop/domain/repositories/get_categories_repository.dart';
import '../../core/use_cases/use_case.dart';
import '../../utils/result.dart';
import '../entities/category.dart';

class GetCategories extends UseCase<Result<List<Category>>> {
  final GetCategoriesRepository repository;

  GetCategories(this.repository);

  @override
  Future<Result<List<Category>>> call() async {
    return await repository.getCategories();
  }
}
