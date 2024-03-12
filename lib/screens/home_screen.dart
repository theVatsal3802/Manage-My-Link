import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manage_my_link/screens/add_link_screen.dart';
import 'package:manage_my_link/screens/auth_screen.dart';
import 'package:manage_my_link/utils/constants.dart';
import 'package:manage_my_link/widgets/link.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int getCount(
    double height,
    double width,
  ) {
    if (height < width) {
      return 4;
    } else if (height > width && height < width * 0.75) {
      return 3;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          "My Workspace",
          textScaler: TextScaler.noScaling,
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then(
                (_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthScreen.routeName,
                    (route) => false,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddLinkScreen.routeName);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        tooltip: "Add New Link",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(Constants.linkCollection)
                .where(
                  "user",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getCount(
                    MediaQuery.of(context).size.height,
                    MediaQuery.of(context).size.width,
                  ),
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return LinkWidget(
                    id: snapshot.data!.docs[index].id,
                    link: snapshot.data!.docs[index].get("link"),
                    name: snapshot.data!.docs[index].get("name"),
                    imageUrl: snapshot.data!.docs[index].get("imageUrl"),
                  );
                },
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
              );
            }),
      ),
    );
  }
}
