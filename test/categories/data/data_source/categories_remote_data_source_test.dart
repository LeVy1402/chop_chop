import 'package:chop_chop/categories/data/data_source/categories_remote_data_source.dart';
import 'package:chop_chop/categories/data/models/category_list_model.dart';
import 'package:chop_chop/categories/data/models/category_model.dart';
import 'package:chop_chop/core/auth/token_provider.dart';
import 'package:chop_chop/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'categories_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client, TokenProvider])
void main() {
  late CategoriesRemoteDataSource dataSource;
  late MockClient mockClient;
  late MockTokenProvider mockTokenProvider;

  setUp(() {
    mockClient = MockClient();
    mockTokenProvider = MockTokenProvider();
    dataSource = CategoriesRemoteDataSourceImpl(
      client: mockClient,
      tokenProvider: mockTokenProvider,
    );
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

  void setUpMockTokenProviderWithToken(String token) {
    when(mockTokenProvider.getToken()).thenAnswer((_) async => token);
  }

  void setUpMockTokenProviderWithoutToken() {
    when(mockTokenProvider.getToken()).thenAnswer((_) async => null);
  }

  group('getCategories', () {
    final tNumberTriviaModel = CategoryListModel(
      total: 9,
      data: [
        const CategoryModel(
          name: 'Appetizers',
          imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
        ),
        const CategoryModel(
          name: 'Rice Bowls & Main Dishes',
          imageUrl:
              'https://images.unsplash.com/photo-1512058564366-18510be2db19',
        ),
        const CategoryModel(
          name: 'Noodle Specialties',
          imageUrl:
              'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841',
        ),
        const CategoryModel(
          name: 'Vegetarian Delights',
          imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554',
        ),
        const CategoryModel(
          name: 'Grilled Favorites',
          imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462',
        ),
        const CategoryModel(
          name: 'Side Dishes & Extras',
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        ),
        const CategoryModel(
          name: 'Large Fruit Tea - 44kr',
          imageUrl:
              'https://images.unsplash.com/photo-1499638673689-79a0b5115d87',
        ),
        const CategoryModel(
          name: 'Large Milk Tea - 48kr',
          imageUrl: 'https://images.unsplash.com/photo-1558857563-b371033873b8',
        ),
        const CategoryModel(
          name: 'Extra Toppings - 5kr',
          imageUrl:
              'https://images.unsplash.com/photo-1526318896980-cf78c088247c',
        ),
      ],
    );

    test('should get token from TokenProvider', () async {
      const tToken = 'test-token-123';
      setUpMockTokenProviderWithToken(tToken);
      setUpMockClientSuccess200();

      await dataSource.getCategories();

      verify(mockTokenProvider.getToken()).called(1);
    });

    test(
      'should perform a GET request with Authorization header when token is provided',
      () async {
        const tToken = 'test-token-123';
        setUpMockTokenProviderWithToken(tToken);
        setUpMockClientSuccess200();

        await dataSource.getCategories();

        verify(
          mockClient.get(
            Uri.parse('http://localhost:3001/categories'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tToken',
            },
          ),
        ).called(1);
      },
    );

    test(
      'should perform a GET request without Authorization header when token is null',
      () async {
        setUpMockTokenProviderWithoutToken();
        setUpMockClientSuccess200();

        await dataSource.getCategories();

        verify(
          mockClient.get(
            Uri.parse('http://localhost:3001/categories'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );

    test(
      'should perform a GET request without Authorization header when token is empty',
      () async {
        setUpMockTokenProviderWithToken('');
        setUpMockClientSuccess200();

        await dataSource.getCategories();

        verify(
          mockClient.get(
            Uri.parse('http://localhost:3001/categories'),
            headers: {'Content-Type': 'application/json'},
          ),
        ).called(1);
      },
    );

    test(
      'should return CategoryListModel when the response code is 200 (success)',
      () async {
        const tToken = 'test-token-123';
        setUpMockTokenProviderWithToken(tToken);
        setUpMockClientSuccess200();

        final result = await dataSource.getCategories();

        expect(result, equals(tNumberTriviaModel));
      },
    );

    test('should return CategoryListModel even without token', () async {
      setUpMockTokenProviderWithoutToken();
      setUpMockClientSuccess200();

      final result = await dataSource.getCategories();

      expect(result, equals(tNumberTriviaModel));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () {
        const tToken = 'test-token-123';
        setUpMockTokenProviderWithToken(tToken);
        setUpMockClientFailure404();

        final call = dataSource.getCategories;
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );

    test('should throw a ServerException when the response code is 500', () {
      const tToken = 'test-token-123';
      setUpMockTokenProviderWithToken(tToken);
      when(
        mockClient.get(any, headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response('Server error', 500));

      final call = dataSource.getCategories;
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });

    test('should throw ServerException when network error occurs', () async {
      const tToken = 'test-token-123';
      setUpMockTokenProviderWithToken(tToken);
      when(
        mockClient.get(any, headers: anyNamed('headers')),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.getCategories(),
        throwsA(TypeMatcher<Exception>()),
      );
    });
  });
}
