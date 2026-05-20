import 'package:chop_chop/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnection])
void main() {
  late MockInternetConnection mockInternetConnection;
  late NetworkInfoImp networkInfo;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImp(mockInternetConnection);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnection.hasInternetAccess',
      () async {
        when(
          mockInternetConnection.hasInternetAccess,
        ).thenAnswer((_) async => true);
        final result = await networkInfo.isConnected;
        verify(mockInternetConnection.hasInternetAccess).called(1);
        expect(result, true);
      },
    );
  });
}
