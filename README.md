[![pub package](https://img.shields.io/pub/v/near_api_dart.svg)](https://pub.dev/packages/near_api_dart)
[![package publisher](https://img.shields.io/pub/publisher/near_api_dart.svg)](https://pub.dev/packages/near_api_dart/publisher)

A Future-based library for querying Near Protocol's RPC providers.

This package contains a set of low-level classes that make it
easy to interact with the Near Protocol's RPC APIs. It's multi-platform 
with limited dependencies for use in mobile, desktop, or browser apps. 

Ths package is designed to follow the [Near RPC API documentation] as closely
as possible.

[Near RPC API documentation]: https://docs.near.org/api/rpc/introduction

## Using

The easiest way to use this library is via the top-level ```Near``` class.

```dart
import 'package:near_api_dart/near_api_dart.dart';

void main() async {
  // Initialize the Near object
  Near near = Near();
  // Select a provider
  JsonRpcProvider rpc = near.providers.jsonRpcProvider('https://rpc.testnet.near.org');
  // Get the balance of an account
  try {
    BigInt balance = await rpc.getBalance('guest-book.testnet');
    print(balance);
    // Do stuff with the balance
  } catch (e) {
    print(e.toString());
    // Handle errors
  }
  // Close the connection
  rpc.close();
}

```

## Handling RPC Responses

Responses comprise of a `Result`, or an `Error` which will be thrown
for you to handle accordingly.


## Getting Help
Submit an issue on [github].

[github]: https://github.com/0xdir/near_api_dart

## How to contribute
All feedback and suggestions for improvements are welcome:
1. Open a discussion on [github]
2. Discuss proposed changes
3. Submit a PR (optional)

[github]: https://github.com/0xdir/near_api_dart

## Support my work
This package is possible thanks to the people and companies 
who donate money, services or time to keep the project running.

If you're interested in becoming a Sponsor, Backer or Contributor
to expand the project, reach out to me on [github].

[github]: https://github.com/0xdir/near_api_dart

Or buy my coffee at `0xdir.near`.


