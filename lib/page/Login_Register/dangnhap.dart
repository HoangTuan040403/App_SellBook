import 'dart:convert';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class dangnhapWidget extends StatefulWidget {
  const dangnhapWidget({Key? key}) : super(key: key);

  @override
  State<dangnhapWidget> createState() => _loginwidgetState();
}

class _loginwidgetState extends State<dangnhapWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = true;
 
  @override
  void initState() {
    super.initState();
   }

 Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('http://172.168.1.248:3000/api/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final user = responseData['user'];

    if (user != null) {
      String pass = user['password'];
      String eMail = user['email'];
      String id = user['_id'];

      // Lưu thông tin người dùng vào SharedPreferences
      await SharedPreferencesHelper.saveUserCredentials(id,pass,eMail);

      print('Đăng nhập thành công!');
      print(responseData);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Mainpage()));
    } else {
      _showErrorSnackBar('Lỗi: Tên người dùng không tồn tại trong phản hồi.');
    }
  } else {
    _showErrorSnackBar('Đăng nhập thất bại. Vui lòng kiểm tra lại email và mật khẩu.');
  }
}

void _showErrorSnackBar(String message) {
  print(message);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),  
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Chào mừng!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D9194),
                ),
              ),
              const Text(
                'Đăng nhập vào tài khoản của bạn',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  border: InputBorder.none,
                  labelText: "Mật khẩu",
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Handle "Quên mật khẩu" logic here
                  print('Quên mật khẩu');
                },
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.label_important_outlined,
                    color: Color(0xFF4D9194),
                    size: 30.0,
                  ),
                  Text('Hoặc đăng nhập bằng hình thức khác'),
                  Icon(
                    Icons.label_important_outlined,
                    color: Color(0xFF4D9194),
                    size: 30.0,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {
                        // Handle Facebook login
                        print('Đăng nhập bằng Facebook');
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    loginUser(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4D9194),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            
            ],
          ),
        ),
      ),
    );
  }
} 