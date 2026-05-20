import 'package:chop_chop/core/error/exceptions.dart';
import 'package:chop_chop/data/data_source/categories_remote_data_source.dart';
import 'package:chop_chop/data/models/category_list_model.dart';
import 'package:chop_chop/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../fixtures/fixture_reader.dart';
import 'categories_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CategoriesRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = CategoriesRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    when(
      mockClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response(fixture('categories.json'), 200));
  }

  void setUpMockClientFailure404() {
    when(
      mockClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getCategories', () {
    final tNumberTriviaModel = CategoryListModel(
      total: 2,
      data: [
        CategoryModel(name: 'name', imageUrl: 'imageUrl'),
        CategoryModel(name: 'name', imageUrl: 'imageUrl'),
      ],
    );
    test(
      '''should perform a GET request on a URL with categories
          being the endpoint and with application/json header''',
      () async {
        setUpMockClientSuccess200();
        await dataSource.getCategories();
        verify(
          mockClient.get(
            Uri.parse('http://localhost:3001/categories'),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return CategoryListModel when the reponse code is 200 (success)',
      () {
        setUpMockClientSuccess200();
        final result = dataSource.getCategories();
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () {
        setUpMockClientFailure404();
        final call = dataSource.getCategories;
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
