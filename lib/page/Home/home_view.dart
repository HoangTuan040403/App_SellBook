import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/best_seller_cell.dart';
import 'package:doan_cuahangbansach/page/Home/common_widget/genres_cell.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:doan_cuahangbansach/page/product/SearchPage.dart';
import 'package:doan_cuahangbansach/page/product/TrangTheLoai.dart';
import 'package:doan_cuahangbansach/page/product/carosel.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  // khai báo danh sách sản phẩm, danh mục
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  List<CateGorys> loaiSach = [];

// api
  //lây dnah sách danh mục
  String uri = 'http://172.168.1.248:3000';

  Future<List<CateGorys>> fetchCategories() async {
    final url = Uri.parse('$uri/api/categories');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<CateGorys> categories =
            jsonList.map((json) => CateGorys.fromJson(json)).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // lấy danh sách sản phẩm
  //String uri = 'http://172.18.48.1:3000/api/products';

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$uri/api/products');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Product> pros =
            jsonList.map((json) => Product.fromJson(json)).toList();
        return pros;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // tim kiem
  bool searchB = false;
  final TextEditingController _searchController = TextEditingController();

  late CartItemCountProvider _cartItemCountProvider;

  Future<void> _loadCartItems() async {
    try {
      String? idCus = await SharedPreferencesHelper.getId();
      if (idCus != null) {
        _cartItemCountProvider.loadCartItems(idCus);
      } else {
        print('Customer ID is null.');
      }
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _cartItemCountProvider =
        Provider.of<CartItemCountProvider>(context, listen: false);
    _loadCartItems();
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = lstProduct;
      } else {
        filteredProducts = lstProduct.where((product) {
          return product.name?.toLowerCase().contains(query.toLowerCase()) ??
              false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "Trang chủ",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartItemCountProvider>(
            builder: (context, cartProvider, child) {
              int itemCount = cartProvider.itemCount;
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  if (itemCount > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D9194),
                        borderRadius: BorderRadius.circular(media.width * 0.5),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.08,
                    ),

                    //Thanh search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.7)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF4D9194),
                            ),
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchPage()));
                            },
                          ),
                          hintText: "Nhập tên sản phẩm...",
                        ),
                      ),
                    ),

                    SizedBox(
                      width: media.width,
                      height: media.width * 0.65,
                      child: ImageCarousel(),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Bán chạy",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.9,
                      child: FutureBuilder<List<Product>>(
                        future: fetchProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 8,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final itemPro = snapshot.data![index];
                                if (index < 5) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailProduct(product: itemPro),
                                        ),
                                      );
                                    },
                                    child: BestSellerCell(itemPro, context),
                                  );
                                }
                                return null;
                              },
                            );
                          }
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Thể loại",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 190,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const theloaiWidget(),
                                ),
                              );
                            },
                            child: const Text(
                              'Xem Thêm',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4D9194),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // thể loại -------------------------
                    SizedBox(
                      height: media.width * 0.6,
                      child: FutureBuilder<List<dynamic>>(
                          future: fetchCategories(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 8,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final itemPro = snapshot.data?[index];
                                if (index < 5) {
                                  return genres_cell(
                                      itemPro,
                                      context,
                                      index % 2 == 0
                                          ? const Color(0xff1C4A7E)
                                          : const Color(0xffC65135));
                                }
                                return null;
                              },
                            );
                          }),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Vừa xem",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.9,
                      child: FutureBuilder<List<Product>>(
                        future: fetchProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 8,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final itemPro = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailProduct(product: itemPro),
                                      ),
                                    );
                                  },
                                  child: BestSellerCell(itemPro, context),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.25,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

   
}
