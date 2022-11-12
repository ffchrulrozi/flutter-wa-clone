import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  late List<GroupChatModel> groupChatModels = List<GroupChatModel>.empty();

  Future<void> readJson() async {
    final String response = await rootBundle.loadString("data/groupChat.json");
    Iterable<dynamic> json = jsonDecode(response);
    setState(() {
      groupChatModels = List<GroupChatModel>.from(
          json.map((model) => GroupChatModel.fromJson(model)));
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
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          const Text("C TIF")
        ]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: groupChatModels
            .map<Widget>(
              (groupChatModel) => Card(
                color: groupChatModel.isByCurrentUser
                    ? const Color.fromARGB(95, 56, 248, 88)
                    : Colors.white,
                margin: groupChatModel.isByCurrentUser
                    ? const EdgeInsets.only(right: 15, left: 75, bottom: 10)
                    : const EdgeInsets.only(left: 15, right: 75, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    groupChatModel.isByCurrentUser
                        ? Row()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                groupChatModel.phone,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orangeAccent),
                              ),
                              Text(
                                groupChatModel.name,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                    const SizedBox(height: 5),
                    Text(groupChatModel.msg),
                  ]),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class GroupChatModel {
  String phone;
  String name;
  String msg;
  bool isByCurrentUser;

  GroupChatModel(this.phone, this.name, this.msg, this.isByCurrentUser);

  factory GroupChatModel.fromJson(dynamic json) {
    return GroupChatModel(json['phone'] as String, json['name'] as String,
        json['msg'] as String, json['isByCurrentUser'] as bool);
  }
}
