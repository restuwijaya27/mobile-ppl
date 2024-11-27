import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/dosen/controllers/dosen_controller.dart';
import 'package:myapp/app/modules/dosen/views/dosen_update_view.dart';

class DosenView extends GetView<DosenController> {
  void showOption(String id) async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Aksi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildOptionTile(
                icon: Icons.edit,
                title: 'Update',
                onTap: () {
                  Get.back();
                  Get.to(
                    DosenUpdateView(),
                    arguments: id,
                  );
                },
              ),
              _buildOptionTile(
                icon: Icons.delete,
                title: 'Hapus',
                onTap: () {
                  Get.back();
                  controller.delete(id);
                },
              ),
              _buildOptionTile(
                icon: Icons.close,
                title: 'Close',
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Get.put(DosenController()).streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data?.docs ?? [];
            return listAllDocs.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE3F2FD), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: listAllDocs.length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        var data = listAllDocs[index].data() as Map<String, dynamic>;

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0D47A1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              data["nama"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            subtitle: Text(
                              "NIDN: ${data["nidn"]}",
                              style: TextStyle(
                                color: Colors.blue.shade700,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF0D47A1),
                              ),
                              onPressed: () => showOption(listAllDocs[index].id),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: 100,
                          color: Color(0xFF0D47A1),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Tidak Ada Data Dosen",
                          style: TextStyle(
                            color: Color(0xFF0D47A1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF0D47A1),
            ),
          );
        },
      ),
    );
  }
}