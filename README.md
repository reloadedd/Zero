# Zero

<br />
<p align="center">
    <img src="app/assets/images/zero_rounded.png" alt="Zero Logo" width="500px"  />
</p>
<br />

<p align="center">Zero is an OS-agnostic chat application, primarily meant to be used on Android, that stores the messages on cloud using zero-knowledge encryption for message storage.</p>

---
## Setup Amplify
```shell
$ amplify configure
$ amplify init
$ amplify pull --sandboxId bdd74b4a-dd9c-45c8-9ff4-5d4b26e5afef
$ amplify add auth
$ amplify add storage
```

## Packages Used
- bip39 (Bitcoin Improvement Proposal 39), [pub.dev](https://pub.dev/packages/bip39)
- shared_preferences, [pub.dev](https://pub.dev/packages/shared_preferences)
- AWS Amplify libraries, [Amplify Docs](https://docs.amplify.aws/lib/q/platform/flutter/)
- Pointy Castle, [pub.dev](https://pub.dev/packages/pointycastle)
- encrypt, [pub.dev](https://pub.dev/packages/encrypt)

## Resources
- Dart language tour. [Dart](https://dart.dev/guides/language/language-tour)
- Building beautiful UIs using Flutter. [Google Codelabs](https://codelabs.developers.google.com/codelabs/flutter)
- What is Zero-Knowledge Encryption? [Tresorit](https://tresorit.com/blog/zero-knowledge-encryption/)
- How could a system be zero-knowledge? [StackOverflow](https://security.stackexchange.com/a/66324)
- Secure way to hold private keys in the Android app? [StackOverflow](https://security.stackexchange.com/a/242398)
- Flutter Welcome Screen With PageView. [Joseph Ajayi](https://medium.com/@adekoyeajayi/flutter-welcome-screen-with-pageview-624e20001bdb)
- How to Build a Chat App UI With Flutter and Dart. [freeCodeCamp](https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/)
- Learning how to use AWS Amplify in Flutter. [LogRocket Blog](https://blog.logrocket.com/learning-aws-amplify-flutter/)
- How to generate safe RSA keys deterministically using a seed? [StackOverflow](https://stackoverflow.com/a/72047475)
- Pointy Castle, RSA tutorial. [Github](https://github.com/bcgit/pc-dart/blob/master/tutorials/rsa.md)
- Dart/Flutter – How to convert String to Uint8List and vice versa. [Coflutter](https://coflutter.com/dart-flutter-how-to-convert-string-to-uint8list/)

## Changelog
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). In order to view the
changes for each version, please consult the [CHANGELOG](CHANGELOG.md) file.

## License
The **Zero** project is available under the GNU General Public License v3.0 License.
For the full license text please read the [LICENSE](LICENSE) file.