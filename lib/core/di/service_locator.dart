import 'package:chop_chop/categories/domain/repositories/get_categories_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../auth/data/auth_repository.dart';
import '../../categories/data/data_source/categories_remote_data_source.dart';
import '../../categories/data/repositories/categories_repository_impl.dart';
import '../../categories/domain/use_cases/get_categories.dart';
import '../auth/dev_token_provider.dart';
import '../auth/token_provider.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Singleton - HTTP client
  getIt.registerSingleton<http.Client>(http.Client());

  // Singleton - Token provider
  getIt.registerSingleton<TokenProvider>(DevTokenProvider());

  // Singleton - Auth
  getIt.registerSingleton<AuthRepository>(AuthRepository());

  // Lazy singleton - Data source
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
        () => CategoriesRemoteDataSourceImpl(
      client: getIt<http.Client>(),
      tokenProvider: getIt<TokenProvider>(),
    ),
  );

  // Lazy singleton - Repository
  getIt.registerLazySingleton<CategoriesRepositoryImpl>(
        () => CategoriesRepositoryImpl(
      remoteDataSource: getIt<CategoriesRemoteDataSource>(),
    ),
  );

  // Lazy singleton - Usecase
  getIt.registerLazySingleton<GetCategories>(
        () => GetCategories(getIt<GetCategoriesRepository>()),
  );
}
