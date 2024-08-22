import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:doan_cuahangbansach/data/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

 
class CusEditInfo extends StatefulWidget {
  final String? customerId;
  const CusEditInfo({Key? key, this.customerId}) : super(key: key);

  @override
  _CusEditInfoState createState() => _CusEditInfoState();
}

class _CusEditInfoState extends State<CusEditInfo> {
  File? _backgroundImage;
  File? _avatarImage;
  late Customer _customer = Customer();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
  }

  Future<void> _loadCustomerData() async {
    final response = await http.get(Uri.parse('http://172.18.48.1:3000/api/users/${widget.customerId}'));
    if (response.statusCode == 200) {
      setState(() {
        _customer = Customer.fromJson(json.decode(response.body));
        fullNameController.text = _customer.fullNameCus ?? '';
        addressController.text = _customer.addressCus ?? '';
        emailController.text = _customer.emailCus ?? '';
        phoneNumberController.text = _customer.phoneNumCus ?? '';
        genderController.text = _customer.genderCus ?? '';
      });
    } else {
      throw Exception('Failed to load customer');
    }
  }

 Future<void> updateUserData() async {
  final url = Uri.parse('http://172.18.48.1:3000/api/users/${widget.customerId}');
  final response = await http.put(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "email": emailController.text,
      "tenuser":fullNameController.text,
      "phoneNumber": phoneNumberController.text,
      "diaChi":addressController.text,
      "genderCus":genderController.text,
    }),
  );

  if (response.statusCode == 200) {
    print('Cập nhật thông tin người dùng thành công.');
    // Xử lý sau khi cập nhật thành công
    Navigator.of(context).pop(); // Quay trở lại màn hình trước đó sau khi cập nhật thành công
  } else {
    print('Lỗi khi cập nhật thông tin người dùng: ${response.body}');
    // Xử lý lỗi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: Text('Không thể cập nhật thông tin người dùng: ${response.body}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


  Future<void> _pickBackgroundImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAvatarImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin người dùng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickBackgroundImage,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: _backgroundImage != null && _backgroundImage is File
                      ? DecorationImage(
                          image: FileImage(_backgroundImage!),
                          fit: BoxFit.cover,
                        )
                      : _backgroundImage != null && _backgroundImage is String
                          ? DecorationImage(
                              image: AssetImage(_backgroundImage as String),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/images/background.jpeg'),
                              fit: BoxFit.cover,
                            ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(80),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          // Navigate to settings page if needed
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade400,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: _pickBackgroundImage,
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: _pickAvatarImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: _avatarImage != null
                              ? FileImage(_avatarImage!)
                              : const NetworkImage(
                                  'https://www.dog-on-it-parks.com/blog/wp-content/uploads/2018/06/Sting-300x225.jpg',
                                ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade400,
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black),
                                onPressed: _pickAvatarImage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Tên đầy đủ',
            controller: fullNameController,
            onChanged: (value) {
              setState(() {
                _customer.fullNameCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Địa chỉ',
            controller: addressController,
            onChanged: (value) {
              setState(() {
                _customer.addressCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Email',
            controller: emailController,
            onChanged: (value) {
              setState(() {
                _customer.emailCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Số điện thoại',
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _customer.phoneNumCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Giới tính',
            controller: genderController,
            onChanged: (value) {
              setState(() {
                _customer.genderCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                updateUserData();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Lưu thông tin'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Thông tin đã được lưu',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đồng ý'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
