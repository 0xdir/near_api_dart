import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get transaction status', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.transactionStatus(
      'FAQS4NPvgSVKcL1sA8SkfaAc8rpyXBDn24mtYsLFea3h',
      'sbv2-authority.testnet',
    ).then((value) => expect(
      value,
      completes,
    ));
    rpc.close();
  });
}
