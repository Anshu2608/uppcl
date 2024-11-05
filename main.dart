import 'package:flutter/material.dart';
import 'package:uppcl/online_payment_status.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaymentStatus(),
      debugShowCheckedModeBanner: false,
    );
  }
}
