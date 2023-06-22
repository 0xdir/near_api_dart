/// A helper class to parse code from a result.
///
/// Select between [codeBase64] and [hash] for the desired format.
class GetCodeResult {
  Map<String, dynamic> result;
  late String codeBase64;
  late String hash;

  GetCodeResult(this.result) {
    codeBase64 = result['code_base64'];
    hash = result['hash'];
  }
}
