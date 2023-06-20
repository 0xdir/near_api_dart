import './providers/json_rpc_provider.dart';

/// A Future-based library for querying Near RPC providers.
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
