// ignore_for_file: depend_on_referenced_packages
// ignore_for_file: invalid_use_of_visible_for_overriding_member

import 'package:batucadapp/constants.dart';
import 'package:batucadapp/core/providers/client_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../../create_container.dart';

class MockClientNetwork extends AsyncNotifier<Dio>
    with Mock
    implements ClientNetwork {}

void main() {
  const dioOkResponseCode = 200;
  group('ClientNetwork build', () {
    test('Dio is configured with correct base URL and language', () async {
      final baseOptions = BaseOptions(
        baseUrl: Endpoint.basePath.path,
        connectTimeout: Constants.connectTimeout,
        receiveTimeout: Constants.receiveTimeout,
        queryParameters: {'language': 'en'},
      );
      final dio = Dio(baseOptions);
      final mock = MockClientNetwork();
      when(mock.build).thenReturn(dio);
      final container = createContainer(
        overrides: [clientNetworkProvider.overrideWith(() => mock)],
      );

      final readDio = await container.read(clientNetworkProvider.future);
      DioAdapter(dio: readDio).onGet(
        Endpoint.basePath.path,
        (server) => server.reply(dioOkResponseCode, 'OK'),
      );

      final response = await readDio.get<dynamic>(Endpoint.basePath.path);

      expect(response.data, 'OK');
      expect(
        readDio.options,
        isA<BaseOptions>()
            .having(
          (options) => options.baseUrl,
          'baseUrl',
          Endpoint.basePath.path,
        )
            .having(
          (options) => options.queryParameters,
          'queryParameters',
          {'language': 'en'},
        ),
      );
    });
  });
}
