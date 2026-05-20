import 'dart:convert';

import 'package:chop_chop/categories/data/models/category_model.dart';
import 'package:chop_chop/categories/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tCategoryModel = CategoryModel(
    name: 'Appetizers',
    imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
  );

  test('should be a subclass of Category', () {
    expect(tCategoryModel, isA<Category>());
  });

  test('should return a valid model', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('category.json'));
    // act
    final result = CategoryModel.fromJson(jsonMap);
    // assert
    expect(result, tCategoryModel);
  });

  test('should return a JSON map containing the proper data', () async {
    // act
    final result = tCategoryModel.toJson();
    // assert
    final expectedJsonMap = {
      "nameEN": "Appetizers",
      "url": 'https://images.unsplash.com/photo-1544025162-d76694265947',
    };
    expect(result, expectedJsonMap);
  });
}
