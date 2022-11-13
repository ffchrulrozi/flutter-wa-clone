import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa/src/page/home/home_chat_list.dart';
import 'package:wa/src/page/home/home_status_list.dart';
import 'package:wa/src/page/home/home_call_list.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wa/src/controller/group_chat.dart';

void main(List<String> args) {
  runApp(Wa());

  //OneSignal
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("8fc25b82-e223-4b76-a57b-6485e7880d07");
  OneSignal.shared.promptUserForPushNotificationPermission();
}

enum Menu { itemOne, itemTwo, itemThree, itemFour, itemFive }

class Wa extends StatelessWidget {
  Wa({Key? key}) : super(key: key);
  final Controller c = Get.put(Controller());
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
                Obx(() => Text("WA Clone #${c.count}")),
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
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: "Chats"),
                Tab(text: "Statuses"),
                Tab(text: "Calls"),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              HomeChatList(),
              HomeStatusList(),
              HomeCallList()
            ],
          ),
        ),
      ),
    );
  }
}
