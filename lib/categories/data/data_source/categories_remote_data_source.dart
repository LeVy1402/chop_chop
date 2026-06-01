import 'dart:convert';
import '../../../core/auth/token_provider.dart';
import '../../../core/config/app_config.dart';
import '../../../core/error/exceptions.dart';
import '../models/category_list_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoriesRemoteDataSource {
  /// Call the http://localhost:3001/categories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CategoryListModel> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;
  final TokenProvider tokenProvider;

  CategoriesRemoteDataSourceImpl({
    required this.client,
    required this.tokenProvider,
  });

  @override
  Future<CategoryListModel> getCategories() async {
    final token = await tokenProvider.getToken();
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    final uri = Uri.parse('${AppConfig.baseUrl}/categories');
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return CategoryListModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
