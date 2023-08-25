import 'package:flutter/material.dart';
import 'package:untitled/service/auth/login_register.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: pages(index),
                ),
                index == 2
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginRegister()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue),
                              child: const Text(
                                'get start',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 1,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> pages(int index) {
  return [
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index == 0
              ? const Color.fromARGB(255, 81, 62, 6)
              : Color.fromARGB(255, 213, 201, 162)),
      height: 5,
      width: 100,
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index == 1
              ? const Color.fromARGB(255, 81, 62, 6)
              : Color.fromARGB(255, 213, 201, 162)),
      height: 5,
      width: 100,
    ),
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index == 2
              ? const Color.fromARGB(255, 81, 62, 6)
              : Color.fromARGB(255, 213, 201, 162)),
      height: 5,
      width: 100,
    ),
  ];
}
