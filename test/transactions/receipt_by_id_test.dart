import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() {
  test('Get receipt by Id', () {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc
        .receiptById(
          '2EbembRPJhREPtmHCrGv3Xtdm3xoc5BMVYHm3b2kjvMY',
        )
        .then((value) => expect(
              value,
              completes,
            ));
    rpc.close();
  });
}
