import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/catagory.dart';
import 'package:untitled/detail_page.dart';
import 'package:untitled/service/post_service.dart';

Widget UserName() {
  final _auth = FirebaseAuth.instance;
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "loading...",
            style: TextStyle(color: Colors.brown),
          );
        }
        var data = snapshot.data!.docs
            .where((element) => _auth.currentUser!.uid == element.id)
            .toList();
        Map<String, dynamic> name = data[0].data();

        return Text(name['name']);
      }));
}

// Map<String, dynamic> data =
//             snapshot.data!.docs[0].data() as Map<String, dynamic>;

Widget ImagePost(String path) {
  return Container(
    height: 200,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
    child: FutureBuilder(
        future: FireStoreDataBase().getData(path),
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
          return Image.network(
            "${snapshot.data.toString()}.jpg",
            fit: BoxFit.cover,
            width: 400,
          );
        })),
  );
}

Widget HeadText(String text) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
    child: GestureDetector(
      child: Text(
        text,
        style: TextStyle(
            color: Color.fromARGB(255, 52, 40, 4),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget CatagoryItems(BuildContext context) {
  return ListView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.all(10),
    children: [
      causes(context, Icons.food_bank_sharp, "Food"),
      causes(context, Icons.school, "education"),
      causes(context, Icons.water_drop, "water"),
      causes(context, Icons.collections, "shalter"),
    ],
  );
}

Widget causes(BuildContext context, IconData icon, String text) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Catagory(name: text)));
    },
    child: Container(
      height: 30,
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 30,
            color: const Color.fromARGB(255, 109, 84, 7),
          ),
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 109, 84, 7),
            ),
          )
        ],
      ),
    ),
  );
}

Widget PostListItem(BuildContext context, DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  void onTap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(data: data)));
  }

  return Container(
    padding: EdgeInsets.all(25),
    margin: EdgeInsets.only(bottom: 25),
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 236, 223),
        borderRadius: BorderRadius.circular(25)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImagePost(data['ImageUrl']),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadText(data['title']),
                Text('Target: ${data['money']}'),
              ],
            ),
            buttom('Detail', 70, onTap)
          ],
        )
      ],
    ),
  );
}

Widget buttom(String text, double size, void Function() onTap) {
  return Container(
    width: size,
    height: 30,
    margin: EdgeInsets.only(right: 10),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 103, 79, 6),
        borderRadius: BorderRadius.circular(10)),
    child: GestureDetector(
      onTap: onTap,
      child: Text(
        "Detail",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget UserInfo(String id) {
  final _auth = FirebaseAuth.instance;
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "loading...",
            style: TextStyle(color: Colors.brown),
          );
        }
        var data =
            snapshot.data!.docs.where((element) => id == element.id).toList();
        Map<String, dynamic> name = data[0].data();

        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadText('fandraser'),
            Text('Name: ${name['name']}'),
            Text('Email: ${name['email']}'),
            Text('Phone: ${name['phone']}'),
            Text('Account: ${name['account']}'),
          ],
        ));
      }));
}
