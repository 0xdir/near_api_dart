/// Near RPC API methods
///
/// Supports those listed on https://docs.near.org/api/rpc/
abstract class Provider {
  /// Retrieve information about an account's access keys.
  ///
  /// Returns information about a single access key for given account.
  /// If permission of the key is FunctionCall, it will return more
  /// details such as the allowance, receiver_id, and method_names.
  Future<Map<String, dynamic>> viewAccessKey(
    String accountId,
    String publicKey, {
    /// [finality] may be 'final' or 'optimistic'.
    String finality = 'final',
  });

  /// Get all access keys for a given [accountId].
  Future<Map<String, dynamic>> viewAccessKeyList(
    String accountId, {
    String finality = 'final',
  });

  /// View access key changes (single)
  ///
  /// Returns individual access key changes in a specific block.
  /// Pass one or more [keys] containing account_id and public_key.
  Future<Map<String, dynamic>> viewAccessKeyChangesSingle(
    List<Map<String, dynamic>> keys, {
    String finality = 'final',
    String changesType = 'single_access_key_changes',
  });

  /// View access key changes (all)
  ///
  /// Returns changes to all access keys of a specific block.
  /// Pass an array of [accountIds] to query multiple accounts.
  Future<Map<String, dynamic>> viewAccessKeyChangesAll(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'all_access_key_changes',
  });

  /// Query the network and get details about specific blocks.
  ///
  /// Select by blocks by [blockId] or [blockHash].
  /// Defaults to [finality]='final'.
  Future<Map<String, dynamic>> blockDetails({
    String finality = 'final',
    int? blockId,
    String? blockHash,
  });

  /// Changes in Block
  ///
  /// Returns changes in block for given block height or hash.
  /// Search by [blockId] or [finality], but not both.
  /// Defaults to [finality]='final' and returns the latest block details.
  Future<Map<String, dynamic>> changesInBlock({
    String finality = 'final',
    int? blockId,
  });

  /// Returns details of a specific chunk.
  ///
  /// You can run a block details query to get a valid chunk hash.
  /// Provide either [chunkId] or both [blockId] and [shardId].
  Future<Map<String, dynamic>> chunkDetails({
    String? chunkId,
    int? blockId,
    int? shardId,
  });

  /// Gets the balance of the account with the specified [accountId].
  ///
  /// Choose between 'final' and 'optimistic' for [finality].
  Future<BigInt> getBalance(
    String accountId, {
    String finality = 'final',
  });

  /// Returns the contract code (Wasm binary) deployed to the
  /// account. Choose between receiving the code in 'base64' or 'hash'
  /// for [mode]. Defaults to hash.
  Future<String> getCode(
    String accountId, {
    String finality = 'final',
    String mode = 'hash',
  });

  /// Returns basic account information.
  Future<Map<String, dynamic>> viewAccount(
    String accountId, {
    String finality = 'final',
  });

  /// View account changes
  ///
  /// Returns account changes from transactions in a given account.
  Future<Map<String, dynamic>> viewAccountChanges(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'account_changes',
  });

  /// View contract state
  ///
  /// Returns the state (key value pairs) of a contract based on
  /// the key prefix (base64 encoded). Pass an empty string
  /// for prefix_base64 if you would like to return the entire state.
  /// Please note that the returned state will be base64 encoded as well.
  Future<Map<String, dynamic>> viewContractState(
    String accountId, {
    String finality = 'final',
    String prefixBase64 = '',
  });

  /// View contract state changes
  ///
  /// Returns the state change details of a contract based on
  /// the key prefix (encoded to base64). Pass an empty string
  /// for this param if you would like to return all state changes.
  Future<Map<String, dynamic>> viewContractStateChanges(
    List<String> accountIds, {
    String finality = 'final',
    String keyPrefixBase64 = '',
  });

  /// View contract code changes
  ///
  /// Returns code changes made when deploying a contract.
  /// Change is returned is a base64 encoded WASM file.
  Future<Map<String, dynamic>> viewContractCodeChanges(
    List<String> accountIds, {
    String finality = 'final',
  });

  /// Call a contract function
  ///
  /// Allows you to call a contract method as a view function.
  /// Result is an array of bytes, to be specific it is an ASCII code of 0
  /// [methodName] eg. name_of_a_example.testnet_method
  /// [argsBase64] method_arguments_base_64_encoded
  Future<Map<String, dynamic>> callFunction(
    String accountId,
    String methodName,
    String argsBase64, {
    String finality = 'final',
  });

  /// Retrieve gas price
  ///
  /// Returns gas price for a specific [blockHeight] or [blockHash].
  /// No arguments will return the most recent block's gas price.
  Future<Map<String, dynamic>> gasPrice({
    int? blockHeight,
    String? blockHash,
  });

  /// Genesis Config
  ///
  /// Returns current genesis configuration.
  Future<Map<String, dynamic>> genesisConfig();

  /// Protocol Config
  ///
  /// Returns most recent protocol configuration or a specific
  /// queried block. Useful for finding current storage
  /// and transaction costs.
  Future<Map<String, dynamic>> protocolConfig({
    int? blockId,
    String finality = 'final',
  });

  /// Node Status
  ///
  /// Returns general status of a given node (sync status, nearcore node version, protocol version, etc), and the current set of validators.
  Future<Map<String, dynamic>> nodeStatus();

  /// Network Info
  ///
  /// Returns the current state of node network connections (active peers,
  /// transmitted data, etc.)
  Future<Map<String, dynamic>> networkInfo();

  /// Validation Status
  ///
  /// Queries active validators on the network returning details and the state
  /// of validation on the blockchain.To get the status of a specific block,
  /// use [blockHash] or [blockId] of the latest block in an epoch.
  /// Defaults to retrieving the status of the latest block if no parameters
  /// are provided.
  Future<Map<String, dynamic>> validationStatus({
    int? blockId,
    String? blockHash,
  });

  /// Send transaction (async)
  ///
  /// Sends a transaction and immediately returns transaction hash.
  /// [signedTransaction] must be encoded in base64.Final transaction results can be queried using Transaction Status
  /// or NEAR Explorer using the returned hash.
  Future<String> sendTransactionAsync(
    String signedTransaction,
  );

  /// Send transaction (await)
  ///
  /// Sends a transaction and waits until transaction is fully complete.
  /// Has a 10 second timeout. [signedTransaction] must be encoded in base64.
  Future<Map<String, dynamic>> sendTransactionAwait(
    String signedTransaction,
  );

  /// Transaction Status
  ///
  /// Queries status of a transaction by [transactionHash] sent by
  /// [senderAccountId]. Returns the final transaction result.
  Future<Map<String, dynamic>> transactionStatus(
    String transactionHash,
    String senderAccountId,
  );

  /// Transaction Status with Receipts
  ///
  /// Queries status of a transaction by [transactionHash] sent by
  /// [senderAccountId]. Returns the final transaction result and
  /// details of all receipts. [senderAccountId] is used to determine
  /// which shard to query for transaction.
  Future<Map<String, dynamic>> transactionStatusWithReceipts(
    String transactionHash,
    String senderAccountId,
  );

  /// Receipt by ID
  ///
  /// Fetches a receipt by it's [receiptId] as is, without a status
  /// or execution outcome.
  Future<Map<String, dynamic>> receiptById(
    String receiptId,
  );

  /// Maintenance Windows
  ///
  /// Query the maintenance windows in current epoch for a validator.
  /// The maintenance windows for a specific validator are future block
  /// height ranges in current epoch, in which the validator does not
  /// need produce block or chunk.
  /// If the provided [accountId] is not a validator, then it will return
  /// the range from now to the end of the epoch.
  Future<List<dynamic>> maintenanceWindows(
    String accountId,
  );

  /// Close the client.
  void close();
}
