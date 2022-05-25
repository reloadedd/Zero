import 'dart:typed_data';
import "package:pointycastle/export.dart";
import 'package:zero/constants.dart';
import 'mnemonic.dart';

/* Credits: https://github.com/bcgit/pc-dart/blob/master/tutorials/rsa.md */
class RSA {
  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
      Mnemonic mnemonic,
      {int bitLength = G_RSA_BIT_LENGTH}) {
    /* Use the Fortuna PRNG in order to generate random data */
    SecureRandom secureRandom = SecureRandom('Fortuna')
      ..seed(KeyParameter(mnemonic.getEntropyFromMnemonic()));

    /* Create an RSA key generator and initialize it */
    final keyGen = RSAKeyGenerator();
    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
        secureRandom));

    /* Use the generator */
    final pair = keyGen.generateKeyPair();

    /* Cast the generated key pair into the RSA key types */
    final publicKey = pair.publicKey as RSAPublicKey;
    final privateKey = pair.privateKey as RSAPrivateKey;

    return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(
        publicKey, privateKey);
  }

  Uint8List encrypt(RSAPublicKey publicKey, Uint8List dataToEncrypt) {
    final encryptor = OAEPEncoding(RSAEngine())
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey)); // true=encrypt

    return _processInBlocks(encryptor, dataToEncrypt);
  }

  Uint8List decrypt(RSAPrivateKey privateKey, Uint8List cipherText) {
    final decryptor = OAEPEncoding(RSAEngine())
      ..init(false,
          PrivateKeyParameter<RSAPrivateKey>(privateKey)); // false=decrypt

    return _processInBlocks(decryptor, cipherText);
  }

  Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
    final numBlocks = input.length ~/ engine.inputBlockSize +
        ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

    final output = Uint8List(numBlocks * engine.outputBlockSize);

    var inputOffset = 0;
    var outputOffset = 0;
    while (inputOffset < input.length) {
      final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
          ? engine.inputBlockSize
          : input.length - inputOffset;

      outputOffset += engine.processBlock(
          input, inputOffset, chunkSize, output, outputOffset);

      inputOffset += chunkSize;
    }

    return (output.length == outputOffset)
        ? output
        : output.sublist(0, outputOffset);
  }
}
