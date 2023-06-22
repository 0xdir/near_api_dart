import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {

  test("Get information about an account's access keys", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    String accountId = 'client.chainlink.testnet';
    String publicKey =
        'ed25519:H9k5eiU4xXS3M4z8HzKJSLaZdqGdGwBG49o7orNC4eZW';
    rpc.viewAccessKey(accountId, publicKey).then((value) => expect(
          value,
          completes,
        ));
    rpc.close();
  });
}
