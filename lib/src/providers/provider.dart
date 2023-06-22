/// Defines Near RPC API methods.
///
/// Supports those listed on https://docs.near.org/api/rpc/
abstract class Provider {
  /// Retrieve information about an account's access keys.
  ///
  /// Returns information about a single access key for an [accountId].
  /// If permission of the key is FunctionCall, it will return more
  /// details such as the allowance, receiver_id, and method_names.
  Future<Map<String, dynamic>> viewAccessKey(
    String accountId,
    String publicKey, {
    /// [finality] may be 'final' or 'optimistic'.
    String finality = 'final',
  });

  /// Get all access keys for an [accountId].
  Future<Map<String, dynamic>> viewAccessKeyList(
    String accountId, {
    String finality = 'final',
  });

  /// View access key changes (single)
  ///
  /// Returns individual access key changes in a specific block.
  /// Expects one or more [keys] containing account_id and public_key.
  ///
  /// eg.
  /// {'account_id': 'guest-book.testnet', 'public_key': 'the_pub_key'}
  Future<Map<String, dynamic>> viewAccessKeyChangesSingle(
    List<Map<String, dynamic>> keys, {
    String finality = 'final',
    String changesType = 'single_access_key_changes',
  });

  /// View access key changes (all)
  ///
  /// Returns changes to all access keys of a specific block.
  /// Pass an array of [accountIds] to query multiple accounts.
  ///
  /// eg. 'first.testnet', 'second.testnet'
  Future<Map<String, dynamic>> viewAccessKeyChangesAll(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'all_access_key_changes',
  });

  /// Query the network and get details about specific blocks.
  ///
  /// Select by blocks by [blockId] or [blockHash].
  /// Gets details of the latest block if no params are provided.
  Future<Map<String, dynamic>> blockDetails({
    String finality = 'final',
    int? blockId,
    String? blockHash,
  });

  /// Changes in Block
  ///
  /// Returns changes in block for given block height or hash.
  /// Search by [blockId] or [finality], but not both.
  /// Gets changes in the latest block if no params are provided.
  Future<Map<String, dynamic>> changesInBlock({
    String finality = 'final',
    int? blockId,
  });

  /// Returns details of a specific chunk.
  ///
  /// You can run a block details query to get a valid chunk hash.
  /// Provide either [chunkId], or both [blockId] and [shardId].
  Future<Map<String, dynamic>> chunkDetails({
    String? chunkId,
    int? blockId,
    int? shardId,
  });

  /// Gets the balance of the account with the specified [accountId].
  Future<BigInt> getBalance(
    String accountId, {
    String finality = 'final',
  });

  /// Returns the contract code (Wasm binary) deployed to the
  /// account.
  ///
  /// Choose between receiving the code in 'base64' or 'hash' using [mode].
  /// Defaults to 'hash' if no [mode] is provided.
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
  /// Get account changes from transactions for ane or more [accountIds].
  Future<Map<String, dynamic>> viewAccountChanges(
    List<String> accountIds, {
    String finality = 'final',
    String changesType = 'account_changes',
  });

  /// View contract state
  ///
  /// Returns the state (key value pairs) of a contract based on
  /// the key prefix (base64 encoded).
  ///
  /// Pass an empty string for [prefixBase64] to return the entire state
  /// in base64.
  Future<Map<String, dynamic>> viewContractState(
    String accountId, {
    String finality = 'final',
    String prefixBase64 = '',
  });

  /// View contract state changes
  ///
  /// Returns the state change details of a contract based on
  /// the key prefix (encoded to base64).
  ///
  /// Pass an empty string for [keyPrefixBase64] to return all
  /// state changes.
  Future<Map<String, dynamic>> viewContractStateChanges(
    List<String> accountIds, {
    String finality = 'final',
    String keyPrefixBase64 = '',
  });

  /// View contract code changes
  ///
  /// Returns code changes made when deploying a contract.
  /// Each change is returned as a base64 encoded WASM file.
  Future<Map<String, dynamic>> viewContractCodeChanges(
    List<String> accountIds, {
    String finality = 'final',
  });

  /// Call a contract function
  ///
  /// Call a contract method as a view function.
  ///
  /// Expects base 64 encoded method arguments for [argsBase64].
  Future<Map<String, dynamic>> callFunction(
    String accountId,
    String methodName,
    String argsBase64, {
    String finality = 'final',
  });

  /// Retrieve gas price
  ///
  /// Gets gas price for a specific [blockHeight] or [blockHash].
  /// Returns the latest block's gas price if no parameters are provided.
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
  /// Gets protocol configuration for a [blockId].
  ///
  /// Useful for finding current storage and transaction costs.
  Future<Map<String, dynamic>> protocolConfig({
    int? blockId,
    String finality = 'final',
  });

  /// Node Status
  ///
  /// Gets the status of the node and the current set of validators.
  Future<Map<String, dynamic>> nodeStatus();

  /// Network Info
  ///
  /// Returns the current state of node network connections.
  Future<Map<String, dynamic>> networkInfo();

  /// Validation Status
  ///
  /// Queries active validators on the network returning details
  /// and the state of validation on the blockchain.
  ///
  /// To get the status of a specific block, provide [blockHash]
  /// or the [blockId] of the latest block in the epoch.
  ///
  /// Defaults to retrieving the status of the latest block
  /// if no parameters are provided.
  Future<Map<String, dynamic>> validationStatus({
    int? blockId,
    String? blockHash,
  });

  /// Send transaction (async)
  ///
  /// Sends a transaction and immediately returns transaction hash.
  ///
  /// [signedTransaction] must be encoded in base64.
  ///
  /// Final transaction results can be queried using [transactionStatus]
  /// or via the NEAR Explorer using the returned hash.
  Future<String> sendTransactionAsync(
    String signedTransaction,
  );

  /// Send transaction (await)
  ///
  /// Sends a transaction and waits until transaction is fully complete
  /// with a 10 second timeout.
  ///
  /// [signedTransaction] must be encoded in base64.
  Future<Map<String, dynamic>> sendTransactionAwait(
    String signedTransaction,
  );

  /// Transaction Status
  ///
  /// Queries status of a transaction by [transactionHash] sent by
  /// [senderAccountId].
  ///
  /// Returns the final transaction result.
  Future<Map<String, dynamic>> transactionStatus(
    String transactionHash,
    String senderAccountId,
  );

  /// Transaction Status with Receipts
  ///
  /// Queries status of a transaction by [transactionHash] sent by
  /// [senderAccountId].
  ///
  /// Returns the final transaction result and details of all receipts.
  ///
  /// [senderAccountId] is used to determine which shard to query
  /// for the transaction.
  Future<Map<String, dynamic>> transactionStatusWithReceipts(
    String transactionHash,
    String senderAccountId,
  );

  /// Receipt by ID
  ///
  /// Gets a receipt by [receiptId], without execution status or outcome.
  Future<Map<String, dynamic>> receiptById(
    String receiptId,
  );

  /// Maintenance Windows
  ///
  /// Gets the maintenance windows in current epoch for a validator.
  ///
  /// The maintenance windows for a specific validator are future block
  /// height ranges in current epoch, in which the validator does not
  /// need produce block or chunk.
  ///
  /// If the provided [accountId] is not a validator, then it will return
  /// the range from now to the end of the epoch.
  Future<List<dynamic>> maintenanceWindows(
    String accountId,
  );

  /// Close the client.
  void close();
}
