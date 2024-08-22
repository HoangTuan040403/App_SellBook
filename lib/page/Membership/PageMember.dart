import 'package:doan_cuahangbansach/page/Membership/Bronze.dart';
import 'package:doan_cuahangbansach/page/Membership/Diamond.dart';
import 'package:doan_cuahangbansach/page/Membership/Gold.dart';
import 'package:doan_cuahangbansach/page/Membership/Silver.dart';
import 'package:flutter/material.dart';


// PageMember widget
class PageMember extends StatefulWidget {
  const PageMember({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageMemberState createState() => _PageMemberState();
}

class _PageMemberState extends State<PageMember> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection); // Add listener for tab selection
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Handle tab selection
  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {}); // Update the state when tab changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(77, 145, 148, 1),
        title: const Text("Hạng thành viên"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: "Đồng",
            ),
            Tab(
              text: "Bạc",
            ),
            Tab(
              text: "Vàng",
            ),
            Tab(
              text: "Kim cương",
            ),
          ],
          indicatorColor: const Color.fromARGB(206, 0, 0, 0),
          labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          labelColor: const Color.fromARGB(206, 0, 0, 0),
          unselectedLabelColor: Colors.white54,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Bronze(),
          Silver(),
          Gold(),
          Diamond(),
        ],
      ),
    );
  }
}
