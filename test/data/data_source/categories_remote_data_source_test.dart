import 'package:chop_chop/data/data_source/categories_remote_data_source.dart';
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

  group('getCategories', () {
    test(
      '''should perform a GET request on a URL with categories
          being the endpoint and with application/json header''',
      () async {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('categories.json'), 200),
        );
        await dataSource.getCategories();
        verify(mockClient.get('http://localhost:3001/categories'));
      },
    );
  });
}
