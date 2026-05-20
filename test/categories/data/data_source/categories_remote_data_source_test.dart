import 'package:chop_chop/categories/data/data_source/categories_remote_data_source.dart';
import 'package:chop_chop/categories/data/models/category_list_model.dart';
import 'package:chop_chop/categories/data/models/category_model.dart';
import 'package:chop_chop/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
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
      total: 9,
      data: [
        CategoryModel(
          name: 'Appetizers',
          imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
        ),
        CategoryModel(
          name: 'Rice Bowls & Main Dishes',
          imageUrl:
              'https://images.unsplash.com/photo-1512058564366-18510be2db19',
        ),
        CategoryModel(
          name: 'Noodle Specialties',
          imageUrl:
              'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841',
        ),
        CategoryModel(
          name: 'Vegetarian Delights',
          imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554',
        ),
        CategoryModel(
          name: 'Grilled Favorites',
          imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462',
        ),
        CategoryModel(
          name: 'Side Dishes & Extras',
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        ),
        CategoryModel(
          name: 'Large Fruit Tea - 44kr',
          imageUrl:
              'https://images.unsplash.com/photo-1499638673689-79a0b5115d87',
        ),
        CategoryModel(
          name: 'Large Milk Tea - 48kr',
          imageUrl: 'https://images.unsplash.com/photo-1558857563-b371033873b8',
        ),
        CategoryModel(
          name: 'Extra Toppings - 5kr',
          imageUrl:
              'https://images.unsplash.com/photo-1526318896980-cf78c088247c',
        ),
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
      () async {
        setUpMockClientSuccess200();
        final result = await dataSource.getCategories();
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
