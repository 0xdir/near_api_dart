import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('View contract state', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    String accountId = 'guest-book.testnet';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.viewContractState(accountId).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
