import 'package:flutter/material.dart';
import 'package:zero/data/pages.dart';
import 'package:zero/screens/chat.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double currentPage = 0.0;
  final _pageViewController = PageController();
  bool addedRouteToFinalPage = false;

  List<Widget> slides = pages
      .sublist(0, pages.length - 1)
      .map((item) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 220.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      Text(item['header'],
                          style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0XFF3F3D56),
                              height: 2.0)),
                      Text(
                        item['description'],
                        style: const TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? const Color(0xFF256075)
                    : const Color(0xFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            PageView.builder(
                controller: _pageViewController,
                itemCount: slides.length,
                itemBuilder: (BuildContext context, int index) {
                  _pageViewController.addListener(() {
                    setState(() {
                      currentPage = _pageViewController.page!;
                    });
                  });

                  if (!addedRouteToFinalPage) {
                    slides.add(Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Image.asset(
                                pages[pages.length - 1]['image'],
                                fit: BoxFit.fitWidth,
                                width: 220.0,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(pages[pages.length - 1]['header'],
                                        style: const TextStyle(
                                            fontSize: 40.0,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0XFF3F3D56),
                                            height: 2.0)),
                                    Text(
                                      pages[pages.length - 1]['description'],
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1.2,
                                          fontSize: 16.0,
                                          height: 1.3),
                                      textAlign: TextAlign.center,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const ChatScreen();
                                          }));
                                        },
                                        child: const Text("Let's begin!"))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )));

                    addedRouteToFinalPage = true;
                  }

                  return slides[index];
                }),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                ))
          ],
        ));
  }
}
