import './providers/json_rpc_provider.dart';

/// The main library object.
class Near {
  Providers providers = Providers();
}

/// Configuration options for selecting types of providers.
///
/// Currently, only JsonRPC is supported.
class Providers {
  JsonRpcProvider jsonRpcProvider(String? url) {
    return JsonRpcProvider(url);
  }
}
