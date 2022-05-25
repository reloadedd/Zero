import 'package:encrypt/encrypt.dart';
import 'package:zero/constants.dart';

class InvalidKeyLengthException implements Exception {
  String _errorMessage = 'Key is not ${G_SALSA20_KEY_LENGTH} characters long';

  InvalidKeyLengthException([String? errorMessage]) {
    if (errorMessage != null) {
      _errorMessage = errorMessage;
    }
  }

  String error() => _errorMessage;

  @override
  String toString() {
    return '${this.runtimeType}: ${this.error()}';
  }
}

class Salsa {
  late final Key _key;
  late final IV _iv;
  late final Encrypter _encrypter;

  Salsa(String key, IV iv) {
    if (key.length != G_SALSA20_KEY_LENGTH) {
      throw InvalidKeyLengthException();
    }

    this._key = Key.fromUtf8(key);
    this._iv = iv;
    this._encrypter = Encrypter(Salsa20(_key));
  }

  Encrypted encrypt(String plaintext) {
    return _encrypter.encrypt(plaintext, iv: _iv);
  }

  String decrypt(Encrypted ciphertext) {
    return _encrypter.decrypt(ciphertext, iv: _iv);
  }
}
