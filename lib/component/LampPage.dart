import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LampPage extends StatefulWidget {
  const LampPage({super.key});

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lightning',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height / 18,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Item 1',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Text(
                          'Lightning',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Item 2',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Text(
                          'Lightning',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Item 3',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Text(
                          'Lightning',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Item 4',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Text(
                          'Lightning',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: MediaQuery.of(context).size.height / 11,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: const Center(
                              child: Text(
                            'Item 5',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                        ),
                        Text(
                          'Lightning',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Divider(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height / 8.5,
          ),
          Expanded(
              flex: 4,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
