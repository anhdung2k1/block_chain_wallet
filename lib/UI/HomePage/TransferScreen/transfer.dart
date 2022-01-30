import 'package:block_chain/UI/HomePage/TransferScreen/transfer_form.dart';
import 'package:block_chain/UI/HomePage/widgets/header_with_search_box.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  String address;
  String privateKey;
  double balance;
  TransferScreen(
      {required this.balance,
      required this.address,
      required this.privateKey,
      Key? key})
      : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          const HeaderWithSearchBox(),
          TransferForm(widget.balance, widget.address, widget.privateKey),
        ]),
      ),
    );
  }
}
