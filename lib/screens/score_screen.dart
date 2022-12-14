// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'dart:async';
import 'package:healthical_flutter_clone/screens/recipe_home.dart';
import 'package:url_launcher/link.dart';

import 'package:flutter/material.dart';
import 'package:healthical_flutter_clone/screens/bmi_calculator_screen.dart';
import 'package:healthical_flutter_clone/screens/health_bot_screen.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScoreScreen extends StatefulWidget {
  final double bmiScore;

  final int age;

  ScoreScreen({Key? key, required this.bmiScore, required this.age})
      : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  Future<void>? _launched;
  // String _launchUrl =
  //     'https://www.youtube.com/watch?v=XhBQVBgeQnU&ab_channel=Maherbanhusen';

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    Uri _launchUrl = Uri.parse(
        'https://youtube.com/playlist?list=PLmTVoL6WRfll1BTzJ7_4W5rUhZF6Zjtjc');
    if (widget.bmiScore > 30) {
      _launchUrl = Uri.parse(
          'https://youtube.com/playlist?list=PLmTVoL6WRfll1BTzJ7_4W5rUhZF6Zjtjc');
    } else if (widget.bmiScore >= 25) {
      _launchUrl = Uri.parse(
          'https://youtube.com/playlist?list=PLmTVoL6WRfll1BTzJ7_4W5rUhZF6Zjtjc');
    } else if (widget.bmiScore >= 18.5) {
      _launchUrl = Uri.parse(
          'https://youtube.com/playlist?list=PLmTVoL6WRflkNT3OiQpgy0o5g3LwjbRoO');
    } else if (widget.bmiScore < 18.5) {
      _launchUrl = Uri.parse(
          'https://youtube.com/playlist?list=PLmTVoL6WRflnOVYfGeVyjFr3cC9bAy9K6');
    }

    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Card(
          elevation: 12,
          shape: const RoundedRectangleBorder(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Your Score",
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            PrettyGauge(
              gaugeSize: 300,
              minValue: 0,
              maxValue: 40,
              segments: [
                GaugeSegment('UnderWeight', 18.5, Colors.red),
                GaugeSegment('Normal', 6.4, Colors.green),
                GaugeSegment('OverWeight', 5, Colors.orange),
                GaugeSegment('Obese', 10.1, Colors.pink),
              ],
              valueWidget: Text(
                widget.bmiScore.toStringAsFixed(1),
                style: const TextStyle(fontSize: 40),
              ),
              currentValue: widget.bmiScore.toDouble(),
              needleColor: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiStatus!,
              style: TextStyle(fontSize: 20, color: bmiStatusColor!),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              bmiInterpretation!,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Re-calculate")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Share.share(
                          "Your BMI is ${widget.bmiScore.toStringAsFixed(1)} at age ${widget.age}");
                    },
                    child: const Text("Share")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => setState(() {
                    _launched = _launchUniversalLinkIos(_launchUrl);
                  }),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Youtube.png"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        //   child: Text(
                        //     "Yotube",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // FutureBuilder<void>(future: _launched, builder: _launchStatus),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Recipe_Home_Screen(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Diet.png"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                        //   child: Text(
                        //     "Yotube",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder<void>(future: _launched, builder: _launchStatus),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void setBmiInterpretation() {
    if (widget.bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (widget.bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (widget.bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (widget.bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}
