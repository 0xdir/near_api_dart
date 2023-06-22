import 'package:test/test.dart';
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  test("Get details about specific blocks", () async {
    String rpcURL = 'https://rpc.testnet.near.org';
    Near near = Near();
    JsonRpcProvider rpc = near.providers.jsonRpcProvider(rpcURL);
    rpc.blockDetails().then((value) => expect(
          value,
          completes,
        ));
    rpc.blockDetails(blockId: 129523889).then((value) => expect(
          value,
          completes,
        ));
    rpc
        .blockDetails(
          blockHash: 'E7kUyJ6BMPY3A77umre8rtnsK43sYDJV2rBmKHdYFUpf',
        )
        .then((value) => expect(
              value,
              completes,
            ));
    rpc.close();
  });
}
