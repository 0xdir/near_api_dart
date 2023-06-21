import 'package:http/http.dart' as http;

import '../providers/provider.dart';
import '../providers/response/error.dart';
import '../providers/response/response.dart';
import '../providers/response/result.dart';
import '../utils/json_rpc.dart';

/// Default if no URL is passed to the provider.
const defaultURL = 'https://rpc.testnet.near.org';

/// Implementation of the JsonRPC Provider.
class JsonRpcProvider extends Provider {
  late final JsonRPC _jsonRPC;

  JsonRpcProvider(String? target) {
    final String url = target ??= defaultURL;
    _jsonRPC = JsonRPC(url, http.Client());
  }

  Future<RPCResponse> _makeRPCCall(
    String method,
    dynamic params,
  ) async {
    try {
      final RPCResponse rpcResponse = await _jsonRPC.call(method, params);
      if (rpcResponse.error.isNotEmpty) throw RPCError(rpcResponse.error);
      return rpcResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BigInt> getBalance(
    String accountId, {
    String finality = 'final',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_account',
      'finality': finality,
      'account_id': accountId,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return BigInt.parse(response.result['amount']);
  }

  @override
  Future<String> getCode(
    String accountId, {
    String finality = 'final',
    String mode = 'hash',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_code',
      'finality': finality,
      'account_id': accountId,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    GetCodeResult getCodeResult = GetCodeResult(response.result);
    switch (mode) {
      case 'base64':
        return getCodeResult.codeBase64;
      default:
        return getCodeResult.hash;
    }
  }

  @override
  Future<Map<String, dynamic>> viewAccount(
    String accountId, {
    String finality = 'final',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_account',
      'finality': finality,
      'account_id': accountId,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewAccountChanges(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'account_changes',
  }) async {
    Map<String, dynamic> params = {
      'changes_type': changesType,
      'finality': finality,
      'account_ids': accountIds,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewContractState(
    String accountId, {
    String finality = 'final',
    String prefixBase64 = '',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_state',
      'finality': finality,
      'account_id': accountId,
      'prefix_base64': prefixBase64,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewContractStateChanges(
    List<String> accountIds, {
    String finality = 'final',
    String keyPrefixBase64 = '',
  }) async {
    Map<String, dynamic> params = {
      'changes_type': 'data_changes',
      'finality': finality,
      'account_ids': accountIds,
      'key_prefix_base64': keyPrefixBase64,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewContractCodeChanges(
    List<String> accountIds, {
    String finality = 'final',
  }) async {
    Map<String, dynamic> params = {
      'changes_type': 'contract_code_changes',
      'finality': finality,
      'account_ids': accountIds,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> callFunction(
    String accountId,
    String methodName,
    String argsBase64, {
    String finality = 'final',
  }) async {
    Map<String, String> params = {
      'request_type': 'call_function',
      'finality': finality,
      'account_id': accountId,
      'method_name': methodName,
      'args_base64': argsBase64,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> gasPrice({
    int? blockHeight,
    String? blockHash,
  }) async {
    dynamic mode;
    if (blockHash == null && blockHeight == null) {
      mode = null;
    } else if (blockHash == null) {
      mode = blockHeight;
    } else {
      mode = blockHash;
    }
    List<dynamic> params = [mode];
    RPCResponse response = await _makeRPCCall('gas_price', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> genesisConfig() async {
    Map<String, String> params = {};
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_genesis_config', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> protocolConfig({
    int? blockId,
    String finality = 'final',
  }) async {
    Map<String, dynamic> params = {};
    if (blockId != null) {
      params['block_id'] = blockId;
    } else {
      params['finality'] = finality;
    }
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_genesis_config', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewAccessKey(
    String accountId,
    String publicKey, {
    String finality = 'final',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_access_key',
      'finality': finality,
      'account_id': accountId,
      'public_key': publicKey,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewAccessKeyList(
    String accountId, {
    String finality = 'final',
  }) async {
    Map<String, String> params = {
      'request_type': 'view_access_key_list',
      'finality': finality,
      'account_id': accountId,
    };
    RPCResponse response = await _makeRPCCall('query', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewAccessKeyChangesSingle(
    List<Map<String, dynamic>> keys, {
    String finality = 'final',
    String changesType = 'single_access_key_changes',
  }) async {
    Map<String, dynamic> params = {
      'changes_type': changesType,
      'finality': finality,
      'keys': keys,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> viewAccessKeyChangesAll(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'all_access_key_changes',
  }) async {
    Map<String, dynamic> params = {
      'changes_type': changesType,
      'finality': finality,
      'account_ids': accountIds,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> blockDetails({
    String finality = 'final',
    int? blockId,
    String? blockHash,
  }) async {
    Map<String, dynamic> params = {};
    if (blockId == null && blockHash == null) {
      params['finality'] = finality;
    } else if (blockHash != null) {
      params['block_id'] = blockHash;
    } else {
      params['block_id'] = blockId;
    }
    RPCResponse response = await _makeRPCCall('block', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> changesInBlock({
    String finality = 'final',
    int? blockId,
  }) async {
    Map<String, dynamic> params = {};
    if (blockId != null) {
      params['block_id'] = blockId;
    } else {
      params['finality'] = finality;
    }
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_changes_in_block', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> chunkDetails({
    String? chunkId,
    int? blockId,
    int? shardId,
  }) async {
    Map<String, dynamic> params = {};
    if (blockId == null && shardId == null) {
      params['chunk_id'] = chunkId;
    } else {
      params['block_id'] = blockId;
      params['shard_id'] = shardId;
    }
    RPCResponse response = await _makeRPCCall('chunk', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> nodeStatus() async {
    List params = [];
    RPCResponse response = await _makeRPCCall('status', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> networkInfo() async {
    List params = [];
    RPCResponse response = await _makeRPCCall('network_info', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> validationStatus({
    String? blockHash,
    int? blockId,
  }) async {
    dynamic mode;
    if (blockHash == null && blockId == null) {
      mode = null;
    } else if (blockHash != null) {
      mode = blockHash;
    } else {
      mode = blockId;
    }
    List<dynamic> params = [mode];
    RPCResponse response = await _makeRPCCall('validators', params);
    return response.result;
  }

  @override
  Future<String> sendTransactionAsync(
    String signedTransaction,
  ) async {
    List<String> params = [signedTransaction];
    RPCResponse response =
        await _makeRPCCall('broadcast_tx_async', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> sendTransactionAwait(
    String signedTransaction,
  ) async {
    List<String> params = [signedTransaction];
    RPCResponse response =
        await _makeRPCCall('broadcast_tx_commit', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> transactionStatus(
    String transactionHash,
    String senderAccountId,
  ) async {
    List<String> params = [transactionHash, senderAccountId];
    RPCResponse response = await _makeRPCCall('tx', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> transactionStatusWithReceipts(
    String transactionHash,
    String senderAccountId,
  ) async {
    List<String> params = [transactionHash, senderAccountId];
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_tx_status', params);
    return response.result;
  }

  @override
  Future<Map<String, dynamic>> receiptById(
    String receiptId,
  ) async {
    Map<String, String> params = {'receipt_id': receiptId};
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_receipt', params);
    return response.result;
  }

  @override
  Future<List<dynamic>> maintenanceWindows(
    String accountId,
  ) async {
    Map<String, dynamic> params = {
      'account_id': accountId,
    };
    RPCResponse response =
        await _makeRPCCall('EXPERIMENTAL_maintenance_windows', params);
    return response.result;
  }

  @override
  void close() {
    _jsonRPC.close();
  }
}
