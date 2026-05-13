import 'package:chop_chop/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({required super.name, required super.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['nameEN'], imageUrl: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'nameEN': name, 'url': imageUrl};
  }
}
