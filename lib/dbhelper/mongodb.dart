 
import 'package:doan_cuahangbansach/dbhelper/const.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection userCollect;
  static late DbCollection proCollect;
  static late DbCollection cateCollect;
 
  // lấy dữ liệu từ collection
  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollect = db.collection(USER);
    proCollect = db.collection(PRODUCT);
    cateCollect = db.collection(CATEGORY);
 
  }
  // danh sách danh mục, thể loại -------------------
  // static Future<List<CateGorys>> getCategory() async {
  //   var categorys = await cateCollect.find().toList();
  //   return categorys.map((category) => CateGorys.fromMap(category)).toList();
  // }

  // danh sach san pham
  // static Future<List<Product>> getProducts() async {
  //   var products = await proCollect.find().toList();
  //   return products.map((product) => Product.fromMap(product)).toList();
  // }

  //   static Future<List<User>> getUser() async {
  //   var users = await userCollect.find().toList();
  //   return users.map((product) => User.fromMap(product)).toList();
  // }

}
