import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:zero/crypto/mnemonic.dart';
import 'package:zero/crypto/salsa.dart';
import 'package:zero/crypto/rsa.dart' as rsa;
import 'package:zero/constants.dart';
import 'package:zero/helpers.dart';

void main() {
  final mnemonic = Mnemonic();
  final mnemonicStr = mnemonic.generateMnemonic();
  print('INFO\tMnemonic: ${mnemonicStr}');
  print('INFO\tThe mnemonic will be used as key for RSA.\n');

  print('=============== RSA-${G_RSA_BIT_LENGTH} ===============');
  rsa.RSA pki = new rsa.RSA();
  final pair = pki.generateRSAkeyPair(mnemonic);
  final public = pair.publicKey;
  final private = pair.privateKey;

  final rsaEncrypted =
      pki.encrypt(public, convertStringToUint8List("Very encrypted with RSA."));
  final rsaDecrypted = pki.decrypt(private, rsaEncrypted);

  print('INFO\tEncrypted (base64): ${Base64Encoder().convert(rsaEncrypted)}');
  print('INFO\tDecrypted (base64): ${Base64Encoder().convert(rsaDecrypted)}');
  print('INFO\tDecrypted (text): ${convertUint8ListToString(rsaDecrypted)}');
  print('========================================\n');

  print('=============== Salsa20 ===============');
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  final key = 'keyed123keyed123keyed123keyed123';
  final iv = IV.fromSecureRandom(G_SALSA20_IV_LENGTH);

  print('INFO\tKey length: ${key.length * 8} bits.');

  final encrypter = Salsa(key, iv);
  final encrypted = encrypter.encrypt(plainText);
  final decrypted = encrypter.decrypt(encrypted);

  print('INFO\tEncrypted (base64): ${encrypted.base64}');
  print(
      'INFO\tDecrypted (base64): ${Base64Encoder().convert(decrypted.codeUnits)}');
  print('INFO\tDecrypted (text): ${decrypted}');
  print('=======================================');
}
