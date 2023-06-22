import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get balance of an account', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    String accountId = 'guest-book.testnet';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.getBalance(accountId).then((balance) => expect(
          BigInt.from(100).runtimeType,
          balance.runtimeType,
        ));
    rpc.close();
  });

}
