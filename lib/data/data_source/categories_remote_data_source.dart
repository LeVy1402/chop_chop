import 'dart:convert';

import 'package:chop_chop/data/models/category_list_model.dart';
import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';

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
  Future<CategoryListModel> getCategories() async {
    final response = await client.get(
      Uri.parse('http://localhost:3001/categories'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return CategoryListModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
