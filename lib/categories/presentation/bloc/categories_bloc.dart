import 'package:chop_chop/categories/domain/use_cases/get_categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/result.dart';
import '../../domain/entities/category.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories}) : super(CategoriesInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    CategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(const CategoriesLoading());

    try {
      final Result<List<Category>> result = await getCategories.call();

      if (result is Success<List<Category>>) {
        final List<Category> categories = result.value;
        if (categories.isEmpty) {
          emit(const CategoriesEmpty());
        } else {
          emit(CategoriesLoaded(categories));
        }
      } else if (result is Failure<List<Category>>) {
        emit(CategoriesError(result.message));
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
