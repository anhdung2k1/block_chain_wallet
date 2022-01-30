import 'package:block_chain/UI/HomePage/LandingPage/landing_page.dart';
import 'package:block_chain/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';

class Begin extends StatefulWidget {
  BeginState createState() => BeginState();
}

class BeginState extends State<Begin> {
  String? addressWallet;
  String? privateKey;
  final _enterPrivateKey = TextEditingController();
  void _getWalletByPrivateKey() async {
    final wallet = await FlutterIconNetwork.instance!
        .getWalletByPrivateKey(_enterPrivateKey.text);
    setState(() {
      privateKey = wallet?['private_key'];
      addressWallet = wallet?['address'];
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LandingPage(addressWallet, privateKey)),
        (route) => false);
  }

  void _createWallet() async {
    final wallet = await FlutterIconNetwork.instance!.createWallet;
    setState(() {
      _enterPrivateKey.text = wallet.privateKey!;
    });
    _getWalletByPrivateKey();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: Colors.white,
        child: Stack(children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.LogIn);
              },
              child: const Icon(Icons.logout),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          ),
          Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 100),
                          height: size.height / 1.5,
                          width: size.width,
                          child: Image.asset(
                              "assets/images/walk_through_3_1.png",
                              fit: BoxFit.fill),
                        ),
                        Container(color: Colors.white.withOpacity(0.2)),
                        Container(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            alignment: Alignment.bottomCenter,
                            child: const Text(
                              'Whollet is ICON\'s Wallet supporting ICX',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Titillium Web',
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  wordSpacing: 3),
                            ))
                      ],
                    ),
                    alignment: Alignment.topCenter,
                  )),
              Expanded(
                flex: 2,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 200, height: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              _createWallet();
                            },
                            child: const Text(
                              'Create new wallet',
                              style: TextStyle(
                                  fontFamily: 'Titillium Web',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF347AF0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ))),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    alignment: Alignment.topCenter,
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an wallet?',
                          style:
                              TextStyle(color: Color(0xFF485068), fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Load wallet',
                                style: const TextStyle(
                                    color: Color(0xFF347AF0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Dialog errorDialog = Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0)), //this right here
                                      child: Container(
                                        height: 300.0,
                                        width: 300.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 35.0),
                                              child: Text(
                                                'Enter private key:',
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Colors.black12,
                                                          style: BorderStyle
                                                              .solid),
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Colors.black12,
                                                          style: BorderStyle
                                                              .solid))),
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25, right: 25),
                                                  child: TextField(
                                                    controller:
                                                        _enterPrivateKey,
                                                    minLines: 3,
                                                    maxLines: 3,
                                                    keyboardType: TextInputType
                                                        .streetAddress,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Ex:00e1d6541bfd8be7d88be0d24516556a34ab477788022fa07b4a6c1d862c4de516",
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(height: 20),
                                            TextButton(
                                                onPressed: () {
                                                  _getWalletByPrivateKey();
                                                },
                                                child: const Text(
                                                  'Load Wallet',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20.0),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            errorDialog);
                                  })
                          ]),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ]));
  }
}
