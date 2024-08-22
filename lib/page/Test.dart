// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:doan_cuahangbansach/data/model/customer.dart';
// import 'package:doan_cuahangbansach/user_service.dart';

// class CusEditInfo extends StatefulWidget {
//   final String? customerId;
//   const CusEditInfo({Key? key, this.customerId}) : super(key: key);

//   @override
//   _CusEditInfoState createState() => _CusEditInfoState();
// }

// class _CusEditInfoState extends State<CusEditInfo> {
//   File? _backgroundImage;
//   File? _avatarImage;
//   late Customer _customer = Customer();

//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadCustomerData();
//   }

//   Future<void> _loadCustomerData() async {
//     try {
//       final customer = await loadCustomerData(widget.customerId!);
//       setState(() {
//         _customer = customer;
//         fullNameController.text = _customer.fullNameCus ?? '';
//         addressController.text = _customer.addressCus ?? '';
//         emailController.text = _customer.emailCus ?? '';
//         phoneNumberController.text = _customer.phoneNumCus ?? '';
//         genderController.text = _customer.genderCus ?? '';
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Thông tin người dùng"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             GestureDetector(
//               onTap: _pickBackgroundImage,
//               child: Container(
//                 height: 220,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(0),
//                     bottomRight: Radius.circular(80),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                   image: _backgroundImage != null
//                       ? DecorationImage(
//                           image: FileImage(_backgroundImage!),
//                           fit: BoxFit.cover,
//                         )
//                       : const DecorationImage(
//                           image: AssetImage('assets/images/background.jpeg'),
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//                 child: Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(0),
//                         bottomRight: Radius.circular(80),
//                       ),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                         child: Container(
//                           color: Colors.black.withOpacity(0.3),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 20,
//                       right: 10,
//                       child: IconButton(
//                         icon: const Icon(Icons.settings, color: Colors.white),
//                         onPressed: () {
//                           // Navigate to settings page if needed
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       left: 10,
//                       child: CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.grey.shade400,
//                         child: IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.black),
//                           onPressed: _pickBackgroundImage,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: GestureDetector(
//                         onTap: _pickAvatarImage,
//                         child: CircleAvatar(
//                           radius: 60,
//                           backgroundImage: _avatarImage != null
//                               ? FileImage(_avatarImage!)
//                               : const NetworkImage(
//                                   'https://www.dog-on-it-parks.com/blog/wp-content/uploads/2018/06/Sting-300x225.jpg',
//                                 ),
//                           child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: CircleAvatar(
//                               radius: 20,
//                               backgroundColor: Colors.grey.shade400,
//                               child: IconButton(
//                                 icon: const Icon(Icons.edit, color: Colors.black),
//                                 onPressed: _pickAvatarImage,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             _buildInfoForm(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoForm() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//           _buildTextField(
//             label: 'Tên đầy đủ',
//             controller: fullNameController,
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(
//             label: 'Địa chỉ',
//             controller: addressController,
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(
//             label: 'Email',
//             controller: emailController,
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(
//             label: 'Số điện thoại',
//             controller: phoneNumberController,
//             keyboardType: TextInputType.number,
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(
//             label: 'Giới tính',
//             controller: genderController,
//           ),
//           const SizedBox(height: 20),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 updateUserData(context, widget.customerId!, emailController, phoneNumberController, addressController);
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 textStyle: const TextStyle(fontSize: 16),
//               ),
//               child: const Text('Lưu thông tin'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       controller: controller,
//       keyboardType: keyboardType,
//     );
//   }

//   Future<void> _pickBackgroundImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _backgroundImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _pickAvatarImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _avatarImage = File(pickedFile.path);
//       });
//     }
//   }
// }
