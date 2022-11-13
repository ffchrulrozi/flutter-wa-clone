import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:wa/src/page/group_chat.dart';
import 'package:get/get.dart';
import 'package:wa/src/controller/group_chat.dart';

class HomeChatList extends StatefulWidget {
  const HomeChatList({Key? key}) : super(key: key);

  @override
  State<HomeChatList> createState() => _HomeChatListState();
}

class _HomeChatListState extends State<HomeChatList> {
  final Controller c = Get.put(Controller());
  late List<HomeChatListModel> homeChatListModels =
      List<HomeChatListModel>.empty();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("data/homeChatList.json");
    Iterable<dynamic> json = jsonDecode(response);
    setState(() {
      homeChatListModels = List<HomeChatListModel>.from(
          json.map((model) => HomeChatListModel.fromJson(model)));
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: homeChatListModels
            .map<Widget>(
              (v) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GroupChat(),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      v.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      v.date,
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                subtitle: Row(
                  children: [
                    v.status == 1
                        ? const Icon(Icons.check)
                        : v.status == 2
                            ? const Icon(Icons.check_circle_outline)
                            : const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.teal,
                              ),
                    Text(v.msg)
                  ],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => c.increment(),
      ),
    );
  }
}

class HomeChatListModel {
  String name;
  String msg;
  String photo;
  int status;
  String date;

  HomeChatListModel(this.name, this.msg, this.photo, this.status, this.date);

  factory HomeChatListModel.fromJson(dynamic json) {
    return HomeChatListModel(json['name'] as String, json['msg'] as String,
        json['photo'] as String, json['status'] as int, json['date'] as String);
  }
}
