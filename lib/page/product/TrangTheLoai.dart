import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class theloaiWidget extends StatefulWidget {
  const theloaiWidget({super.key});

  @override
  State<theloaiWidget> createState() => _HomewidgetAppState();
}

class _HomewidgetAppState extends State<theloaiWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool searchB = false;
  List<Product> lstProduct = [];
  List<Product> filteredProducts = [];
  CateGorys? selectedCategory;

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

  Future<void> loadProducts() async {
    try {
      List<Product> products = await fetchProducts();
      setState(() {
        lstProduct = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // lấy danh sách sản phẩm
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

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return  
       Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              'KBT',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D9194),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.shopping_bag, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 184, 219, 221),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF4D9194),
                        ),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _searchProducts,
                      ),
                      hintText: "Tìm kiếm...",
                    ),
                    onChanged: (query) {
                      setState(() {
                        filteredProducts = lstProduct
                            .where((product) => product.name!
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                        searchB = query.isNotEmpty;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (searchB)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              product.name ?? '',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ${product.price}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.red)),
                                const SizedBox(height: 4),
                                Text(product.des ?? '',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                            onTap: () {
                              // Navigate to product detail page
                            },
                          ),
                        );
                      },
                    )
                  else
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Thể loại',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4D9194),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: FutureBuilder<List<CateGorys>>(
                            future: fetchCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text('No categories available'));
                              } else {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: snapshot.data!.map((category) {
                                    bool isSelected =
                                        selectedCategory?.id == category.id;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          filterProductsByCategory(category);
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 35,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                            //  ? Color.fromARGB(255, 137, 242, 219)
                                            ?Color.fromARGB(255, 184, 219, 221)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isSelected
                                                //? Colors.blue
                                                ?Color.fromARGB(255, 184, 219, 221)
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category.name ?? '',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4D9194),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          child: FutureBuilder<List<Product>>(
                            future: Future.value(
                                filteredProducts), // Use filteredProducts directly
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text('No products available'));
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    final itemPro = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailProduct(product: itemPro,)),
                                        );
                                      },
                                      child: itemGridViewTheloai(itemPro),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    
  }

  void _searchProducts() {
    if (_searchController.text.isNotEmpty) {
      // Navigate to search results page
    }
  }

  void filterProductsByCategory(CateGorys? category) {
    setState(() {
      selectedCategory = category;
      if (category == null) {
        filteredProducts = List.from(lstProduct);
      } else {
        filteredProducts = lstProduct
            .where((product) => product.categoryID == category.id?.toString())
            .toList();
      }
    });
  }

  String normalizeBase64(String base64String) {
    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    return base64String;
  }

  Widget itemGridViewTheloai(Product items) {
    String chuoiBase64 = normalizeBase64(items.img ?? '');
    Uint8List imageBytes = base64Decode(chuoiBase64);
    final formatter = NumberFormat('#,##0', 'en_US');
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.memory(
              imageBytes,
              height: 130,
              errorBuilder: (context, error, stachTrace) =>
                  const Icon(Icons.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Column(
              children: [
                Text(
                  items.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
