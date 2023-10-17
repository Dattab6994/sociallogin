import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sociallogin/controller/controller.dart';
import 'package:sociallogin/view/product_details_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
    controller.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final drawer = Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SafeArea(
        left: false,
        right: false,
        child: Drawer(
          width: 250,
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: FirebaseAuth.instance.currentUser?.photoURL !=
                                null
                            ? Image.network(
                                FirebaseAuth.instance.currentUser?.photoURL ??
                                    '',
                                height: 60,
                              )
                            : Image.asset(
                                'assets/images1.jpeg',
                                height: 60,
                              ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      const Text(
                        'Welcome,',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                          FirebaseAuth.instance.currentUser?.displayName ?? ''),
                      Text(FirebaseAuth.instance.currentUser?.email ?? ''),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.login_outlined,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.dialog(
                      CupertinoAlertDialog(
                        title: const Text('Logout'),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: Theme.of(Get.context!).textTheme.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.blue[700]),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.blue[700]),
                            ),
                            onPressed: () async {
                              await GoogleSignIn().disconnect();
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Scaffold(
        drawer: drawer,
        appBar: AppBar(
          title: const Text('Product List'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.fetchPosts(),
          builder: (context, snapshot) {
            return ListView.separated(
              padding: const EdgeInsets.all(12.0),
              shrinkWrap: true,
              itemCount: controller.productlist.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 4.0,
              ),
              itemBuilder: (context, index) {
                final data = controller.productlist[index];
                return InkWell(
                  onTap: () {
                    Get.to(ProductDetailsPage(model: data));
                  },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 251, 214, 214))),
                    color: Colors.cyan.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Card(
                            color: Colors.green.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data.id.toString()),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.name.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.tagline.toString(),
                                        style: TextStyle(
                                            // fontSize: 16,
                                            color: Colors.grey.shade600,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
