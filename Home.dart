import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'Mobile_id';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Oximetro', 'Estetoscopio'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-7876234173504299/7432477391',
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

//  InterstitialAd createInterstitialAd() {
//    return InterstitialAd(
//        adUnitId: InterstitialAd.testAdUnitId,
//        //Change Interstitial AdUnitId with Admob ID
//        targetingInfo: targetingInfo,
//        listener: (MobileAdEvent event) {
//          print("IntersttialAd $event");
//        });
//  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-7876234173504299~1999175559');
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  int bgColor = 0xff13112C;
  int cardColor = 0xff1D193A;
  static double pHInitial = 7.40;
  static int co2Initial = 40;
  static double hco3Initial = 24;
  String resultado = '';
  double phValue = pHInitial;
  double hco3Value = hco3Initial;
  int co2Value = co2Initial;

//
//  BannerAd myBanner;
//  InterstitialAd myInterstitial;
//
//  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    keywords: <String>[
//      'oximetro',
//      'estetoscópio',
//      'carimbo para profissionais da saúde'
//    ],
//    contentUrl: 'https://flutter.io',
//    childDirected: false,
//    testDevices: <String>[],
//  );

//  void startBanner() {
//    myBanner = BannerAd(
//      adUnitId: 'Gasometria Arterialca-app-pub-7876234173504299~1999175559',
//      size: AdSize.smartBanner,
//      targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        if (event == MobileAdEvent.opened) {
//          // MobileAdEvent.opened
//          // MobileAdEvent.clicked
//          // MobileAdEvent.closed
//          // MobileAdEvent.failedToLoad
//          // MobileAdEvent.impression
//          // MobileAdEvent.leftApplication
//        }
//        print("BannerAd event is $event");
//      },
//    );
//  }

//  void displayBanner() {
//    myBanner
//      ..load()
//      ..show(
//        anchorOffset: 0.0,
//        anchorType: AnchorType.bottom,
//      );
//  }

//  @override
//  void initState() {
//    super.initState();
//    FirebaseAdMob.instance.initialize(
//        appId: "gasoAdmobBannerca-app-pub-7876234173504299/7432477391");
//
//    startBanner();
//    displayBanner();
//  }

//  @override
//  void dispose() {
//    myBanner?.dispose();
//    super.dispose();
//  }

  void calculate() {
    if (phValue < 7.35 && co2Value > 45 && (hco3Value > 22 && hco3Value < 28)) {
      setState(() {
        resultado = 'Acidose Respiratória';
      });
    } else if (phValue < 7.35 && co2Value < 45 && hco3Value < 22) {
      setState(() {
        resultado = 'Acidose Metabólica';
      });
    } else if (phValue < 7.35 && co2Value > 45 && hco3Value < 22) {
      setState(() {
        resultado = 'Acidose Mista';
      });
    } else if (phValue > 7.45 && hco3Value > 26 && co2Value > 35) {
      setState(() {
        resultado = 'Alcalose Metabólica';
      });
    } else if (phValue > 7.45 && co2Value < 35 && hco3Value < 28) {
      setState(() {
        resultado = 'Alcalose Respiratória';
      });
    } else if (phValue > 7.45 && co2Value < 35 && hco3Value > 26) {
      setState(() {
        resultado = 'Alcalose Mista';
      });
    } else if ((phValue >= 7.35 && phValue <= 7.45) &&
        (co2Value <= 45 && co2Value >= 35) &&
        (hco3Value < 29 && hco3Value >= 22)) {
      setState(() {
        resultado = 'Normal';
      });
    } else if ((phValue >= 7.35 && phValue <= 7.45) &&
        (co2Value > 45) &&
        (hco3Value > 26)) {
      setState(() {
        resultado = 'Acidose Respiratória Compensada';
      });
    } else if ((phValue <= 7.35) && (co2Value > 45) && (hco3Value > 26)) {
      setState(() {
        resultado = 'Acidose Respiratória Parcialmente Compensada';
      });
    } else if ((phValue <= 7.35) && (co2Value < 35) && (hco3Value < 22)) {
      setState(() {
        resultado = 'Acidose Metabólica Parcialmente Compensada';
      });
    } else if ((phValue >= 7.35 && phValue <= 7.45) &&
        (co2Value < 35) &&
        (hco3Value < 22)) {
      setState(() {
        resultado = 'Acidose Metabólica Compensada';
      });
    } else {
      setState(() {
        resultado = 'Checar Valores';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
//          leading: Icon(Icons.arrow_back),
//          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(Icons.menu),
//            )
//          ],
          backgroundColor: Color(bgColor),
          elevation: 2.0,
          title: Center(
            child: TextLabel(
              label: 'Gasometria Arterial',
            ),
          ),
        ),
        body: Container(
          color: Color(bgColor),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    ReusableCard(
                      colour: Color(cardColor),
                      marginCard: EdgeInsets.all(15),
                      childCard: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextLabel(
                                label: 'PH',
                                fontColor: Colors.grey,
                                fontSize: 16,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: TextLabel(
                                label: pHInitial.toStringAsFixed(2),
                                fontColor: Colors.white,
                                fontSize: 40,
                              )),
                          Slider(
                            value: pHInitial,
                            min: 6.60,
                            max: 8.20,
                            activeColor: Colors.red,
                            inactiveColor: Colors.red.shade300,
                            onChanged: (double newValue) {
                              setState(() {
                                pHInitial = newValue;
                              });
                            },
                            onChangeStart: (phInitial) {
                              setState(() {
                                resultado = '';
                              });
                            },
                            onChangeEnd: (value) {
                              phValue = value;
                              setState(() {
                                phValue = value;
                              });
                              print(phValue);
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ReusableCard(
                            colour: Color(cardColor),
                            marginCard: EdgeInsets.all(15),
                            childCard: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextLabel(
                                      label: 'CO2',
                                      fontColor: Colors.grey,
                                      fontSize: 16,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextLabel(
                                      label: co2Initial.toString(),
                                      fontColor: Colors.white,
                                      fontSize: 40,
                                    )),
                                Slider(
                                  value: co2Initial.toDouble(),
                                  min: 25,
                                  max: 80,
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.red.shade300,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      co2Initial = newValue.toInt();
                                    });
                                  },
                                  onChangeStart: (phInitial) {
                                    setState(() {
                                      resultado = '';
                                    });
                                  },
                                  onChangeEnd: (value) {
                                    co2Value = value.toInt();
                                    setState(() {
                                      co2Value = value.toInt();
                                    });
                                    print(co2Value);
                                  },
                                )
                              ],
                            ),
                          ),
                          ReusableCard(
                            colour: Color(cardColor),
                            marginCard: EdgeInsets.all(15),
                            childCard: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextLabel(
                                      label: 'HCO3',
                                      fontColor: Colors.grey,
                                      fontSize: 16,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: TextLabel(
                                      label: hco3Initial.toStringAsFixed(0),
                                      fontColor: Colors.white,
                                      fontSize: 40,
                                    )),
                                Slider(
                                  value: hco3Initial,
                                  min: 1.0,
                                  max: 60.0,
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.red.shade300,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      hco3Initial = newValue;
                                    });
                                  },
                                  onChangeStart: (phInitial) {
                                    setState(() {
                                      resultado = '';
                                    });
                                  },
                                  onChangeEnd: (value) {
                                    hco3Value = value;
                                    setState(() {
                                      hco3Value = value;
                                    });
                                    print(hco3Value);
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16.0, bottom: 60),
                  child: TextLabel(
                    label: resultado,
                    fontColor: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(70.0),
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Color(cardColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(1, 4.0),
                  spreadRadius: 0.1),
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.05,
                  offset: Offset(-1, -1.5),
                  spreadRadius: 0.1)
            ],
          ),
          child: FlatButton(
            onPressed: () {
              calculate();
            },
            child: TextLabel(
              label: 'CALCULAR',
              fontColor: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class TextLabel extends StatelessWidget {
  TextLabel({this.label, this.fontColor, this.fontSize});

  final String label;
  final double fontSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: fontSize, color: fontColor, fontWeight: FontWeight.bold),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({this.colour, this.marginCard, this.childCard});

  final Color colour;
  final EdgeInsets marginCard;
  final Widget childCard;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: childCard,
          margin: marginCard,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colour,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(1, 4.0),
                  spreadRadius: 0.1),
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.05,
                  offset: Offset(-0, -1.5),
                  spreadRadius: 0.1)
            ],
          )),
    );
  }
}
