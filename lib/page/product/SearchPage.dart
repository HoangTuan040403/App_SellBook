import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/page/product/ProductPage.dart';
import 'package:doan_cuahangbansach/page/product/detailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String uri = 'http://172.168.1.248:3000';
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool searchB = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('$uri/api/products');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Product> pros =
            jsonList.map((json) => Product.fromJson(json)).toList();
        setState(() {
          products = pros;
          filteredProducts = pros;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  void filterProducts(String query) {
    List<Product> temp = [];
    for (var product in products) {
      if (product.name != null &&
          product.name!.toLowerCase().contains(query.toLowerCase())) {
        temp.add(product);
      }
    }
    setState(() {
      filteredProducts = temp;
      searchB = query.isNotEmpty;
    });
  }
  final TextEditingController _searchController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF7EAEB4),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFF7EAEB4),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: 'Nhập tên sản phẩm',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20),
                        border: InputBorder.none,
                      ),
                      controller: _searchController,
                      onChanged: (query) {
                        filterProducts(query);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productpage(
                            query: _searchController.text,
                            products: products,
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color(0xFF4D9194),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                     if (searchB)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return Container(
                      
                      height:100,
                      child: Card(
                          margin: const EdgeInsets.only(
                            top: 4, bottom: 4,right: 15,left: 15),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailProduct(product: product),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              else
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Gợi ý tìm kiếm',
                            style: TextStyle(
                              color: Color(0xFF1A2857),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Clear search history functionality
                            },
                            child: const Text(
                              'Xóa lịch sử tìm kiếm',
                              style: TextStyle(
                                color: Color(0xFF1A2857),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardProduct(),
                        CardProduct(),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CardProduct(),
                        CardProduct(),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

 
class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SearchListWid(
          title: 'Sách trinh thám',
        ),
        SearchListWid(
          title: 'Sách kinh doanh',
        ),
        SearchListWid(
          title: 'Sách khoa học công nghệ',
        ),
        SearchListWid(
          title: 'Sách thiếu nhi',
        ),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class SearchListWid extends StatelessWidget {
  final String title;

  const SearchListWid({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 1, 20, 48),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

 

class CardProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xFF4D9194)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text(
                        'Công thức Tự Tin - Để Vươn Tới Sự Tư Lập',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '130.000 VND',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '104.000 VND',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D9194),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '-20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SearchResultsPage extends StatelessWidget {
  final String query;
  final List<Product> products;

  const SearchResultsPage({Key? key, required this.query, required this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.where((product) {
      return product.name != null && product.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm cho "$query"'),
      ),
      body: ListView.builder(
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: \$${product.price}',
                      style: const TextStyle(fontSize: 16, color: Colors.red)),
                  const SizedBox(height: 4),
                  Text(product.des ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProduct(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
