import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Call a contract function', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    String validatorAccountId = 'dev-1588039999690';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.callFunction(
      validatorAccountId,
      'get_num',
      'e30=',
    ).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
