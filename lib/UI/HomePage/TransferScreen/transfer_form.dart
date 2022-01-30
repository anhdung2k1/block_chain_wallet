import 'package:block_chain/constants/constants.dart';
import 'package:block_chain/helper/keyboard.dart';
import 'package:block_chain/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';

class TransferForm extends StatefulWidget {
  final double _balance; // balance
  final String _walletAddress; //địa chỉ của ví
  final String _walletPrivateKey; //private key của ví
  const TransferForm(
      this._balance, this._walletAddress, this._walletPrivateKey);
  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final _EnterICX = TextEditingController();
  final _EnterDes = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<String> errors = [];
  String result = '';
  Future<void> _sendICX() async {
    final response = await FlutterIconNetwork.instance!.sendIcx(
        yourPrivateKey: widget._walletPrivateKey,
        destinationAddress: _EnterDes.text,
        value: _EnterICX.text);
    setState(() {
      result = response.txHash.toString();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const Text("Transfer ICX",
              style: TextStyle(fontSize: 34, fontFamily: 'Helvetice')),
          const SizedBox(height: 20),
          buildICXFormField(),
          const SizedBox(height: 20),
          buildAddressFormField(),
          const SizedBox(height: 20),
          ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: 200, height: 70),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                  }
                  setState(() {
                    _sendICX();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChoiceView(
                              txhash: result,
                              addressFrom: widget._walletAddress,
                              addressTo: _EnterDes.text,
                              amount: double.parse(_EnterICX.text));
                        });
                  });
                },
                child: const Text(
                  'Transfer',
                  style: TextStyle(
                      fontFamily: 'Helvetica Neue',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
                style: ElevatedButton.styleFrom(
                    primary: kBackGroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
              ))
        ],
      ),
    );
  }

  TextFormField buildICXFormField() {
    return TextFormField(
      controller: _EnterICX,
      onSaved: (String? newValue) => _EnterICX.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your ICX Value");
        }
        return;
      },
      validator: (value) {
        double.parse(value!) > widget._balance
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: Text(
                      "Your Balance is not Enough to complete this transaction",
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  );
                })
            : null;
        if (value.isEmpty) {
          addError(error: "Please Enter your ICX Value");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "ICX Value",
          hintText: "Enter your ICX",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.money),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          )),
      style: const TextStyle(color: Colors.black),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: _EnterDes,
      onSaved: (String? newValue) => _EnterDes.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your Address");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Please Enter your Address");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Address",
          hintText: "Enter your Address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.streetview),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF9B9B9B)),
            gapPadding: 10,
          )),
      style: const TextStyle(color: Colors.black),
    );
  }
}
