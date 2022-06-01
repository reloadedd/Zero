import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zero/crypto/mnemonic.dart';
import 'package:zero/screens/messages.dart';
import 'package:zero/screens/seed_phrase_confirmation.dart';
import 'dart:ui';

class SeedPhraseGenerationScreen extends StatefulWidget {
  const SeedPhraseGenerationScreen({Key? key}) : super(key: key);

  @override
  State<SeedPhraseGenerationScreen> createState() =>
      _SeedPhraseGenerationScreenState();
}

class _SeedPhraseGenerationScreenState
    extends State<SeedPhraseGenerationScreen> {
  late final String seedPhase = Mnemonic().generateMnemonic();
  late final List<String> seedPhraseSplitted = seedPhase.split(' ');
  bool blurred = true;

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text(
                'Are you sure you wrote down the seed phase? If you lose it, you won\'t be able to recover your account!'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SeedPhraseConfirmationScreen(
                        seedPhraseSplitted: seedPhraseSplitted,
                        seedPhrase: seedPhase,
                      );
                    }));
                  },
                  child: Container(
                      padding: EdgeInsets.all(10), child: const Text('Yes'))),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red.withAlpha(50)),
                      child: const Text('No')))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('hereeeeeeeeeeeeeee - seed');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
            child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(children: <Widget>[
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: Image.asset('assets/icon/icon.png').image,
              maxRadius: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Zero',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.grey.shade900, fontSize: 13),
                )
              ],
            )),
            Container(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red.withAlpha(30)),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        blurred = !blurred;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          blurred == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          blurred == true
                              ? "Reveal Seed Phase"
                              : "Hide Seed Phase",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    )))
          ]),
        )),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: seedPhraseSplitted.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 70),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ImageFiltered(
                    imageFilter: blurred == true
                        ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 5, bottom: 5),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                  '${index + 1}. ${seedPhraseSplitted[index]}',
                                  style: const TextStyle(fontSize: 15)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red.withAlpha(20)),
                            ))));
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                width: double.infinity,
                color: Colors.white,
                child: ElevatedButton(
                  onPressed: () => _delete(context),
                  child: Text('Copied it!'),
                )),
          )
        ],
      ),
    );
  }
}
