import '../../../core/use_cases/use_case.dart';
import '../../../utils/result.dart';
import '../entities/category.dart';
import '../repositories/get_categories_repository.dart';

class GetCategories extends UseCase<Result<List<Category>>> {
  final GetCategoriesRepository repository;

  GetCategories(this.repository);

  @override
  Future<Result<List<Category>>> call() async {
    return await repository.getCategories();
  }
}
