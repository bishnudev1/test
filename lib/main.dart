import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:pay/pay.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'package:http/http.dart' as http;
import 'package:test/payment_config.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // final cron = Cron();

  // final uri = Uri.parse("http://54.176.58.162/api/user/get-users");

  //  cron.schedule(Schedule.parse('*/10 * * * * *'), () async {
  //   print('every 10 seconds');

  //   final res = await http.get(uri);

  //   final data = jsonDecode(res.body);

  //   log(data.toString());
  //});
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  static var _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];


static void onApplePayResult(paymentResult) {
  // Send the resulting Apple Pay token to your server / PSP
}

static void onGooglePayResult(paymentResult) {
  log("Payment result is : ${paymentResult}");
  // Send the resulting Google Pay token to your server / PSP
}

String os = Platform.operatingSystem;

var applePayButton = ApplePayButton(
  paymentConfiguration: PaymentConfiguration.fromJsonString(
      defaultApplePay),
  paymentItems: _paymentItems,
  style: ApplePayButtonStyle.black,
  type: ApplePayButtonType.buy,
  margin: const EdgeInsets.only(top: 15.0),
  onPaymentResult: onApplePayResult,
  loadingIndicator: const Center(
    child: CircularProgressIndicator(),
  ),
);


var googlePayButton = GooglePayButton(
  paymentConfiguration: PaymentConfiguration.fromJsonString(
      defaultGooglePay),
  paymentItems: _paymentItems,
  type: GooglePayButtonType.pay,
  margin: const EdgeInsets.only(top: 15.0),
  onPaymentResult: onGooglePayResult,
  loadingIndicator: const Center(
    child: CircularProgressIndicator(),
  ),
);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cron Job"),
        ),
        body: Center(
          child: Platform.isIOS ? applePayButton : googlePayButton
        ),
      ),
    );
  }
}

