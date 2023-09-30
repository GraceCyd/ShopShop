import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'entity/product.dart';
import 'app_config.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter_application_3/productdetailscreen.dart';
import 'category.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  int categoryValue = 0;
  List<Product> productList = [];
  int productId = 0;
  int currentPageIndex = 0;
  int cartItemCount = 0;
  List<Category> categoryList = [];
  int categoryId = 0;

  @override
  void initState() {
    fetchCategory();
    fetchProduct();
    super.initState();
  }

  void fetchCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${AppConfig.SERVICE_URL}/api/category"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset:UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("access_token")}'
      },
    );

    final json = jsonDecode(response.body);

    print(json["data"]);

    List<Category> store = List<Category>.from(json["data"].map((item) {
      return Category.fromJSON(item);
    }));

    setState(() {
      print(store);
      categoryList = store;
    });
  }

  void fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${AppConfig.SERVICE_URL}/api/products/type/$categoryValue"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("access_token")}'
      },
    );

    final json = jsonDecode(response.body);

    print(json["data"]);

    List<Product> store = List<Product>.from(json["data"].map((item) {
      return Product.fromJSON(item);
    }));

    setState(() {
      print(store);
      productList = store;
    });
  }

  void fetchProductsByCategory(int categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${AppConfig.SERVICE_URL}/api/products/category/$categoryId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("access_token")}'
      },
    );
    print(response.body);
    final json = jsonDecode(response.body);



    List<Product> store = List<Product>.from(json["data"].map((item) {
      return Product.fromJSON(item);
    }));

    setState(() {
      productList = store;
    });
  }
  //ค้นหาสินค้า
  void fetchSearchProduct(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("${AppConfig.SERVICE_URL}/api/products/search/$search"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("access_token")}'
      },
    );
    print(response.body);
    final json = jsonDecode(response.body);
    


    List<Product> store = List<Product>.from(json["data"].map((item) {
      return Product.fromJSON(item);
    }));

    setState(() {
      productList = store;
    });
  }

  Widget getCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          for (Category category in categoryList)
            buildCategoryChipWithImageAndText(category),
        ],
      ),
    );
  }

  Widget buildCategoryChipWithImageAndText(Category category) {
    return ChoiceChip(
      backgroundColor: Color(0xFFFCC0C5), // ตั้งสีพื้นหลังของ ChoiceChip
      selectedColor: Colors.redAccent,
      label: Container(
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/${category.imageUrl}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      selected: category.categoryId == categoryId,
      onSelected: (isSelected) {
        setState(() {
          categoryId = isSelected ? category.categoryId : 0;
          fetchProductsByCategory(categoryId);
        });
      },
    );
  }

  Widget getProductListView() {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      mainAxisSpacing: 20, // ปรับระยะห่างระหว่างรูปภาพตามต้องการ
      crossAxisSpacing: 20, // ปรับระยะห่างระหว่างรูปภาพตามต้องการ
      padding: const EdgeInsets.all(40),
      children: <Widget>[
        for (Product item in productList) buildProductGridItem(item),
      ],
    );
  }

  Widget buildProductGridItem(Product item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: item),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "assets/images/${item.imgesUrl}",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${item.price}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getScreen() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getCategoryList(),
          Expanded(
            child: getProductListView(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFDCDF),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'ค้นหา',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                // เปิดหน้าค้นหาเมื่อคลิกที่ไอคอนค้นหา
                //fetchSearchProduct (value);
                // คุณสามารถเพิ่มโค้ดเปิดหน้าค้นหาที่นี่
              },
            ),
          ),
          onSubmitted: (value) {
            // ค้นหาเมื่อกด Enter บนแป้นพิมพ์
            fetchSearchProduct (value);
            // คุณสามารถเพิ่มโค้ดการค้นหาที่นี่

          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              // เปิดหน้าตะกร้าสินค้าเมื่อคลิกที่ไอคอนตะกร้า
              // คุณสามารถเพิ่มโค้ดเปิดหน้าตะกร้าสินค้าที่นี่
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFFFDCDF),
        child: getScreen(),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "หน้าหลัก"),
          TabData(iconData: Icons.favorite, title: "สำหรับคุณ"),
          TabData(iconData: Icons.shopping_bag, title: "คำสั่งซื้อ"),
          TabData(iconData: Icons.person, title: "โปรไฟล์"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPageIndex = position;
          });
        },
        initialSelection: currentPageIndex,
      ),
    );
  }
}
