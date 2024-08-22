import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class DangkiWidget extends StatefulWidget {
  const DangkiWidget({Key? key}) : super(key: key);

  @override
  State<DangkiWidget> createState() => _DangkiWidgetState();
}

class _DangkiWidgetState extends State<DangkiWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sdtController = TextEditingController();
  bool passwordVisible = true;
  PhoneNumber number = PhoneNumber(isoCode: 'VN');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _sdtController.dispose();
    super.dispose();
  }
  Future<void> registerUser() async {
  final String apiUrl = 'http://192.168.2.14:3000/api/users';  

  if(_emailController.text.isNotEmpty &&
  _passwordController.text.isNotEmpty &&
  _sdtController.text.isNotEmpty){
    if(_emailController.text.length >5 && _passwordController.text.length>5 
    ){
      Map<String, dynamic> user = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
        'phoneNumber': _sdtController.text.trim(),
    };
   print(_sdtController.text.length);
    try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 201) {
      print('User thêm thành công');
    } else {
      print('Đăng ký thất bại: ${response.body}');
    }
  } catch (e) {
    print('Đăng ký thất bại: $e');
  }
    }else{
           print('Đăng ký thất bại: mật khẩu và tài khoản có ít nhất 5 kí tự');
    _showErrorSnackBar('Đăng ký thất bại: mật khẩu và tài khoản có ít nhất 5 kí tự, SĐT là 10 số.');
    }
  
  }
  else{
     print('Đăng ký thất bại: Chưa tiền đầy đủ thông tin');
    _showErrorSnackBar('Đăng ký thất bại: Vui lòng điền đủ thông tin.');
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Chào mừng!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D9194),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Đăng ký ngay hôm nay',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  useBottomSheetSafeArea: false,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                initialValue: number,
                textFieldController: _sdtController,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                inputBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print('Quên mật khẩu');
                },
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {
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
                    registerUser(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4D9194),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w900,
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
