import 'package:flutter/material.dart';
import 'package:wa/src/page/home/homeChatList.dart';
import 'package:wa/src/page/home/homeStatusList.dart';
import 'package:wa/src/page/home/homeCallList.dart';

void main(List<String> args) {
  runApp(const Wa());
}

enum Menu { itemOne, itemTwo, itemThree, itemFour, itemFive }

class Wa extends StatelessWidget {
  const Wa({Key? key}) : super(key: key);
  // String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("WA Clone"),
                      Row(
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          const SizedBox(width: 20),
                          const Icon(Icons.search),
                          PopupMenuButton<Menu>(
                            onSelected: (Menu item) {
                              // setState(() {
                              //   _selectedMenu = item.name;
                              // });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<Menu>>[
                              const PopupMenuItem<Menu>(
                                value: Menu.itemOne,
                                child: Text('New Group'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemTwo,
                                child: Text('New Broadcast'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemThree,
                                child: Text('Linked Devices'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemFour,
                                child: Text('Starred Messages'),
                              ),
                              const PopupMenuItem<Menu>(
                                value: Menu.itemFive,
                                child: Text('Settings'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  bottom: const TabBar(tabs: <Widget>[
                    Tab(text: "Chats"),
                    Tab(text: "Statuses"),
                    Tab(text: "Calls"),
                  ])),
              body: const TabBarView(children: <Widget>[
                HomeChatList(),
                HomeStatusList(),
                HomeCallList()
              ]),
            )));
  }
}
