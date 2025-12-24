import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home.dart';
import 'package:flutter_application_2/screens/product_item.dart';

import 'package:flutter_application_2/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My titel!",

      // เพิ่ม routes ตรงนี้
      routes: {
        //ProductItem': (context) => const ProductItem()},
      },
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text("My Store!"),
        //   backgroundColor: Color(0xFF2F4366),
        //   centerTitle: true,
        // ),
        // body: ProductItem(
        //   token:
        //       'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNSwiZXhwIjoxNzY2MjI2MzE4fQ.s_hr77EOhGjoBi63HCxQM5OJJjqneFRNxo6VQ9cCg4s',
        // ),
        body: LoginScreen(),
      ),
    );
  }
}
