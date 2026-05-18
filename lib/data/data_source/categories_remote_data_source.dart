import 'package:chop_chop/data/models/category_list_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoriesRemoteDataSource {
  /// Call the http://localhost:3001/categories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CategoryListModel> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImpl({required this.client});

  @override
  Future<CategoryListModel> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
}
