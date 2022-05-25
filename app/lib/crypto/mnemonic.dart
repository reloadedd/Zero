import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:zero/constants.dart';

abstract class BaseMnemonic {
  String generateMnemonic();
  Uint8List getSeedFromMnemonic();
  Uint8List getEntropyFromMnemonic();
}

class Mnemonic implements BaseMnemonic {
  late final String mnemonic;

  @override
  String generateMnemonic() {
    this.mnemonic = bip39.generateMnemonic(strength: G_ENTROPY_BYTES_LENGTH);

    return this.mnemonic;
  }

  @override
  Uint8List getSeedFromMnemonic() {
    return bip39.mnemonicToSeed(this.mnemonic);
  }

  @override
  Uint8List getEntropyFromMnemonic() {
    final entropy = bip39.mnemonicToEntropy(this.mnemonic);
    final List<int> codeUnits = entropy.codeUnits;

    return Uint8List.fromList(codeUnits);
  }

  // @override
  // List<String> getKeys(String mnemonic, {int index = 0}) {
  //   final root = bip32.BIP32.fromSeed(bip39.mnemonicToSeed(mnemonic));

  //   bip32.BIP32 child;
  //   if (index != 0) {
  //     final keyDerivationPath = G_ETHEREUM_KEY_DERIVATION_PATH.replaceRange(
  //         G_ETHEREUM_KEY_DERIVATION_PATH.length - 1, null, index.toString());
  //     child = root.derivePath(keyDerivationPath);
  //   } else {
  //     child = root.derivePath(G_ETHEREUM_KEY_DERIVATION_PATH);
  //   }

  //   final childPrivateKey = HEX.encode(child.privateKey!.toList());
  //   final childPublicKey = HEX.encode(child.publicKey.toList());

  //   return [childPublicKey, childPrivateKey];
  // }
}
