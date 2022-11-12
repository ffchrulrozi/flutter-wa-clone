import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../groupChat.dart';

class HomeStatusList extends StatefulWidget {
  const HomeStatusList({Key? key}) : super(key: key);

  @override
  State<HomeStatusList> createState() => _HomeStatusListState();
}

class _HomeStatusListState extends State<HomeStatusList> {
  late List<HomeStatusListModel> homeStatusListModels;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("data/homeStatusList.json");
    Iterable<dynamic> json = jsonDecode(response);
    setState(() {
      homeStatusListModels = List<HomeStatusListModel>.from(
          json.map((model) => HomeStatusListModel.fromJson(model)));
    });
  }

  @override
  initState() {
    super.initState();
    homeStatusListModels = List<HomeStatusListModel>.empty();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: homeStatusListModels
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
                  title: Text(
                    v.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(v.date),
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
      ],
    );
  }
}

class HomeStatusListModel {
  String name;
  String photo;
  String date;

  HomeStatusListModel(this.name, this.photo, this.date);

  factory HomeStatusListModel.fromJson(dynamic json) {
    return HomeStatusListModel(json['name'] as String, json['photo'] as String,
        json['date'] as String);
  }
}
