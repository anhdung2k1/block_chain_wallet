import 'package:block_chain/UI/HomePage/TransferScreen/transfer.dart';
import 'package:block_chain/UI/HomePage/widgets/header_with_search_box.dart';
import 'package:block_chain/UI/HomePage/widgets/service_widget.dart';
import 'package:block_chain/routes/routes.dart';
import 'package:block_chain/widgets/build_copy.dart';
import 'package:block_chain/widgets/navigation_drawer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:block_chain/UI/HomePage/Screen/Apps/apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:block_chain/constants/constants.dart';

class LandingPage extends StatefulWidget {
  final String? addressWallet;
  final String? privateKey;
  LandingPage(this.addressWallet, this.privateKey);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isVisible = true;
  int currentIndex = 0;

  get wallet => null;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  int myAmount = 0;
  bool data = false;
  // ignore: prefer_typing_uninitialized_variables
  double _balance = 0.0;
  void _getBalance() async {
    final balance = await FlutterIconNetwork.instance!
        .getIcxBalance(privateKey: widget.privateKey);
    setState(() {
      _balance = balance.icxBalance;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBalance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> listWidgets = [LandingPage(null, null), const Apps()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text("ICON WALLET",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'avenir',
                color: Colors.white,
              ),
              textAlign: TextAlign.center),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.LogIn);
              },
              icon: const Icon(Icons.logout, color: Colors.white)),
        ],
      ),
      drawer: const NavigationDrawer(),
      body: listWidgets[currentIndex] == listWidgets[0]
          ? SingleChildScrollView(
              child: Column(children: <Widget>[
              const HeaderWithSearchBox(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                  const SizedBox(width: 5),
                  const Text("eWallet",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'ubuntu',
                          fontSize: 25))
                ])
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Account Overview",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                  _isVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility_outlined),
                          color: kPrimaryColor,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility_off_outlined),
                          color: kPrimaryColor,
                        )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffff1f3f6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _isVisible
                            ? Text(
                                "${_balance.toStringAsFixed(4)}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              )
                            : const Text("*******",
                                style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 5),
                        const Text("Current Balance",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400))
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffffac30)),
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        iconSize: 30,
                        onPressed: () {
                          _getBalance();
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Address",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                  Text("Transfer",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                  Text("Withdraw",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir')),
                ],
              ),
              Row(
                children: [
                  Wrap(
                    children: [
                      Container(
                        height: 150,
                        width: 120,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF1F3F6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 40),
                                color: Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned(
                                                    right: -40.0,
                                                    top: -40.0,
                                                    child: InkResponse(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const CircleAvatar(
                                                        child:
                                                            Icon(Icons.close),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    )),
                                                Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Private Key",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Avenir',
                                                                fontSize: 32,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        buildCopy(
                                                            text: widget
                                                                .privateKey!)
                                                      ],
                                                    ),
                                                    Text(widget.privateKey!,
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'avenir',
                                                            color:
                                                                kPrimaryColor)),
                                                    Row(
                                                      children: [
                                                        const Text("Address",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Avenir',
                                                                fontSize: 32,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        buildCopy(
                                                            text: widget
                                                                .addressWallet!)
                                                      ],
                                                    ),
                                                    Text(widget.addressWallet!,
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'avenir',
                                                            color:
                                                                kPrimaryColor)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "Load Address",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'avenir'),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        width: 120,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFF1F3F6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 40),
                                color: Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TransferScreen(
                                                    balance: _balance,
                                                    address:
                                                        widget.addressWallet!,
                                                    privateKey:
                                                        widget.privateKey!)),
                                        (route) => false);
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "Transfer",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'avenir'),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
              Wrap(
                children: [
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 0.7,
                      children: [
                        serviceWidget(img: "sendMoney", name: "Send\nMoney"),
                        serviceWidget(
                            img: "receiveMoney", name: "Receive\nMoney"),
                        serviceWidget(img: "phone", name: "Mobile\nRecharge"),
                        serviceWidget(
                            img: "electricity", name: "Electricity\nBill"),
                        serviceWidget(img: "tag", name: "Cashback\nOffer"),
                        serviceWidget(img: "movie", name: "Movie\nTicket"),
                        serviceWidget(img: "flight", name: "Flight\nTicket"),
                        serviceWidget(img: "more", name: "More\n"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ]))
          : (listWidgets[currentIndex]),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          // TabItem(icon: Icons.transform_outlined, title: 'Transfer'),
          // TabItem(
          //     icon: Icons.account_balance_wallet_outlined, title: 'Withdraw'),
          TabItem(icon: Icons.apps, title: 'Account')
        ],
        height: 60,
        onTap: setBottomBarIndex,
        activeColor: Colors.white,
        backgroundColor: kBluePrimaryColor,
      ),
    );
  }
}