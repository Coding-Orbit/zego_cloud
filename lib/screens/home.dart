import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:zego_cloud/common/widgets/call_invitation.dart';
import 'package:zego_cloud/common/widgets/top_bar.dart';
import 'package:zego_cloud/common/widgets/user_card.dart';
import 'package:zego_cloud/models/user.dart';
import 'package:zego_cloud/services/firebase_service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(
              upperTitle: 'Welcome back,',
              title: FirebaseService.currentUser.name,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseService.buildViews,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
                  if (docs == null || docs.isEmpty) {
                    return const Text('No data');
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final model = UserModel.fromJson(
                        docs[index].data() as Map<String, dynamic>,
                      );
                      if (model.username !=
                          FirebaseService.currentUser.username) {
                        return UserCard(userModel: model);
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
