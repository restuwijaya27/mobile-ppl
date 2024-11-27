import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/dashboard/views/dashboard_view.dart';
import 'package:myapp/app/modules/dosen/views/dosen_add_view.dart';
import 'package:myapp/app/modules/dosen/views/dosen_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_add_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return DashboardAdmin();
  }
}

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final cAuth = Get.find<AuthController>();
  int _index = 0;
  List<Map> _fragment = [
    {
      'title': 'Dashboard',
      'view': DashboardView(),
      'icon': Icons.dashboard,
    },
    {
      'title': 'Data Transaksi',
      'view': MahasiswaView(),
      'icon': Icons.receipt,
      'add': () => MahasiswaAddView(),
    },
    {
      'title': 'Laporan',
      'view': DosenView(),
      'icon': Icons.report,
      'add': () => DosenAddView(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF005DAA), // BRI Blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _fragment[_index]['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => Get.to(_fragment[_index]['add']),
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: _fragment[_index]['view'],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF005DAA), Color(0xFF00A3E1)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Color(0xFF005DAA),
                    ),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ..._buildDrawerItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    return _fragment
            .map((item) => _drawerItem(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () {
                    setState(() => _index = _fragment.indexOf(item));
                    Get.back();
                  },
                ))
            .toList() +
        [
          _drawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Get.back();
              cAuth.logout();
            },
          ),
        ];
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.navigate_next,
        color: Colors.white,
      ),
    );
  }
}