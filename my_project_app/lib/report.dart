// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'app_config.dart';
// import 'package:fl_chart/fl_chart.dart'; // เพิ่ม import

// class ReportPage extends StatefulWidget {
//   @override
//   _ReportPageState createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   List<dynamic> reportData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       final response = await http.get(
//         Uri.parse("${AppConfig.SERVICE_URL}/api/report"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${prefs.getString("access_token")}'
//         },
//       );

//       final json = jsonDecode(response.body);

//       print(json["data"]);

//       if (json["result"] == true) {
//         setState(() {
//           reportData = List.from(json["data"]);
//         });
//       } else {
//         // แสดงข้อความหรือกระทบอื่น ๆ เมื่อมีข้อผิดพลาด
//         print("มีข้อผิดพลาด: ${json['message']}");
//       }
//     } catch (e) {
//       // แสดงข้อความข้อผิดพลาดเมื่อเกิดข้อผิดพลาด
//       print("เกิดข้อผิดพลาด: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('รายงาน'),
//       ),
//       body: reportData.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Column(
//               children: [
//                 SizedBox(height: 40),
//                 Text(
//                   'สินค้าที่แบ่งตามหมวดหมู่',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: BarChart(
//                       BarChartData(
//                         titlesData: FlTitlesData(
//                           show: false,
//                         ),
//                         borderData: FlBorderData(
//                           show: true,
//                         ),
//                         barGroups: reportData.asMap().entries.map((entry) {
//                           final index = entry.key.toDouble();
//                           final value = entry.value['product_count'] as int;

//                           return BarChartGroupData(
//                             x: index.toInt(),
//                             barRods: [
//                               BarChartRodData(
//                                 toY: value.toDouble(), // ให้แกน Y เป็น double
//                                 color: Colors.blue,
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                         // barGroups: List.generate(
//                         //   reportData.length,
//                         //   (index) => BarChartGroupData(
//                         //     x: index,
//                         //     barRods: [
//                         //       BarChartRodData(
//                         //         toY: reportData[index],
//                         //         color: Colors.blue,
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ).toList(),
//                         gridData: FlGridData(show: false),
//                         minY: 0,
//                         maxY: reportData
//                             .map((item) => item['product_count'] as int)
//                             .reduce((value, element) =>
//                                 value > element ? value : element)
//                             .toDouble(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<dynamic> reportData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.get(
        Uri.parse("${AppConfig.SERVICE_URL}/api/report"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("access_token")}'
        },
      );

      final json = jsonDecode(response.body);

      print(json["data"]);

      if (json["result"] == true) {
        setState(() {
          reportData = List.from(json["data"]);
        });
      } else {
        // แสดงข้อความหรือกระทบอื่น ๆ เมื่อมีข้อผิดพลาด
        print("มีข้อผิดพลาด: ${json['message']}");
        // เพิ่มบรรทัดนี้เพื่อตั้งค่า reportData เป็นรายการว่างเมื่อมีข้อผิดพลาด
        reportData = [];
      }
    } catch (e) {
      // แสดงข้อความข้อผิดพลาดเมื่อเกิดข้อผิดพลาด
      print("เกิดข้อผิดพลาด: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
// ignore: unused_local_variable
    final List<String> categoryNames =
        reportData.map((data) => data['category_name'].toString()).toList();

    final Map<String, double> sampleData = Map.fromIterable(reportData,
        key: (data) => data['category_name'].toString(),
        value: (data) =>
            double.parse(data['product_count'].toString()).toInt().toDouble());

    return Scaffold(
      appBar: AppBar(
        title: Text('รายงาน'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'แต่ละหมวดหมู่มีสินค้ากี่อย่าง',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: reportData.isNotEmpty
                  ? PieChart(
                      dataMap: sampleData,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      colorList: [
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.red,
                        Colors.pink,
                        Colors.purple,
                      ],
                      chartType: ChartType.disc,
                      centerText: "รายงาน",
                      legendOptions: LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: true,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
