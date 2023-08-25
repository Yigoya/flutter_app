import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/home_widget.dart';
import 'package:untitled/post.dart';
import 'package:untitled/service/auth/auth_service.dart';
import 'package:untitled/service/post_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void post() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post()));
  }

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
      ),
      body: Padding(
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "hello",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 101, 79, 15),
                              fontSize: 12),
                        ),
                        UserName()
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 30,
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 103, 79, 6),
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            onTap: () => post(),
                            child: Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 111, 87, 12)),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ImagePost(''),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 140,
                    width: double.infinity,
                    child: CatagoryItems(context)),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadText('Emergency help'),
                      Text(
                        "see all",
                        style: TextStyle(
                            color: Color.fromARGB(255, 129, 99, 11),
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc('Food')
                        .collection("post")
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("something is wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "loading...",
                          style: TextStyle(color: Colors.brown),
                        );
                      }
                      var document = snapshot.data!.docs[0];
                      return PostListItem(context, document);
                    })),
              ],
            ),
          )),
    );
  }
}
