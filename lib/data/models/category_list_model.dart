import 'package:chop_chop/data/models/category_model.dart';

class CategoryListModel {
  final int total;
  final List<CategoryModel> data;

  CategoryListModel({required this.total, required this.data});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    final List<CategoryModel> categories = [];
    final List<dynamic> categoryList = json['data'];
    for (final category in categoryList) {
      categories.add(CategoryModel.fromJson(category));
    }
    return CategoryListModel(total: json['total'], data: categories);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['total'] = total;
    json['data'] = data.map((category) => category.toJson()).toList();
    return json;
  }
}
