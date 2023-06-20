import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  // This example showcases calling Near RPC endpoints using this package.

  // Choose which RPC endpoint to call.
  String rpcURL = 'https://rpc.testnet.near.org';
  // Choose an account to test with.
  String accountId = 'guest-book.testnet';
  // Initialize the Near object.
  Near near = Near();
  // Select the provider to use. Currently, only JsonRPC is supported.
  JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);

  // Get the balance of the account.
  try {
    BigInt balance = await rpc.getBalance(accountId);
    print(balance);
  } catch (e) {
    print(e.toString());
  }

  // Get the code deployed to the account.
  try {
    String code = await rpc.getCode(accountId, mode: 'hash');
    print(code);
  } catch (e) {
    print(e.toString());
  }

  // View basic information of an account.
  try {
    var info = await rpc.viewAccount(accountId);
    print(info);
  } catch (e) {
    print(e.toString());
  }

  // Get the most recent block's gas price.
  try {
    var gasPrice = await rpc.gasPrice();
    print(gasPrice);
  } catch (e) {
    print(e.toString());
  }

  // Close the client.
  rpc.close();
}
