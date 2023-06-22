import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get the contract code (Wasm binary) deployed to the account', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    String accountId = 'guest-book.testnet';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.getCode(accountId).then((value) => expect(
          value,
          completes,
        ));
    rpc.getCode(accountId, mode: 'hash').then((value) => expect(
          value,
          completes,
        ));
    rpc.getCode(accountId, mode: 'base64').then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
