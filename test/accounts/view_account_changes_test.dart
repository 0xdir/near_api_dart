import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get account changes', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    String accountId1 = 'guest-book.testnet';
    String accountId2 = 'example.testnet';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.viewAccountChanges([accountId1]).then((value) => expect(
          value,
          completes,
        ));
    rpc.viewAccountChanges([
      accountId1,
      accountId2,
    ]).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
