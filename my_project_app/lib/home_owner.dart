// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/category_list.dart';
import 'package:flutter_application_3/product_list.dart';
// import 'package:flutter_application_3/stock_list.dart';
import 'package:flutter_application_3/screens/login/login.dart';

// ignore: camel_case_types
class Home_owner extends StatelessWidget {
  const Home_owner({Key? key}) : super(key: key);

  static const String _title = 'จัดการข้อมูล';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(_title),
            backgroundColor: Colors.red,
          ),
          body: const MyStatefulWidget(),
          backgroundColor: const Color(0xFFFFDCDF),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      mainAxisSpacing: 20, // ปรับระยะห่างระหว่างรูปภาพตามต้องการ
      crossAxisSpacing: 20, // ปรับระยะห่างระหว่างรูปภาพตามต้องการ
      padding: const EdgeInsets.all(40),
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.orange[200],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.add_shopping_cart, size: 60),
                      Text(
                        "คำสั่งซื้อ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])))),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.green[200],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.account_circle, size: 60),
                      Text(
                        "ข้อมูลลูกค้า",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])))),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red[200],
                child: InkWell(
                    onTap: () {
                      // Navigate to the ProductList screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryList()),
                      );
                    },
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Icon(Icons.category, size: 60),
                          Text(
                            "หมวดหมู่สินค้า",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]))))),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple[200],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.pageview_rounded, size: 60),
                      Text(
                        "จับคู่สินค้า",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])))),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.blueGrey[200],
                child: InkWell(
                    // onTap: () {
                    //   // Navigate to the ProductList screen
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => StockList()),
                    //   );
                    // },
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      Icon(Icons.inventory, size: 60),
                      Text(
                        "สต็อกสินค้า",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]))))),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.yellow[200],
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.supervisor_account, size: 60),
                      Text(
                        "จัดการผู้ดูแลระบบ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])))),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.pink[200],
            child: InkWell(
              onTap: () {
                // Navigate to the ProductList screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductList()),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt, size: 60),
                    Text(
                      "จัดการรายการสินค้า",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red,
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.troubleshoot_rounded, size: 60),
                      Text(
                        "สรุปยอดขาย",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])))),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Color.fromARGB(255, 155, 168, 253),
            child: InkWell(
              onTap: () {
                // Navigate to the logout screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login(logout: true)),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt, size: 60),
                    Text(
                      "ออกจากระบบ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
