import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.hasData) {
            Map<String, dynamic> user = snap.data!.data()!;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 100,
                        child: Image.network(
                          "https://ui-avatars.com/api/?name=${user['name']}&background=random&color=fff&bold=true",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "${user['name'].toString().toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "${user['email']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                if (user["role"] == "Admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                    leading: Icon(Icons.person_add),
                    title: Text("Add Pegawai"),
                  ),
                ListTile(
                  onTap: () =>
                      Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                  leading: Icon(Icons.person),
                  title: Text("Update Profile"),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                  leading: Icon(Icons.vpn_key),
                  title: Text("Update Password"),
                ),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("No Data >///<"),
            );
          }
        },
      ),
    );
  }
}
