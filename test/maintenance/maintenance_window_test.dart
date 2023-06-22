import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get maintenance windows', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.maintenanceWindows('node0').then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
