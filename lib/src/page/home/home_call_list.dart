import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../group_chat.dart';

class HomeCallList extends StatefulWidget {
  const HomeCallList({Key? key}) : super(key: key);

  @override
  State<HomeCallList> createState() => _HomeCallListState();
}

class _HomeCallListState extends State<HomeCallList> {
  late List<HomeCallListModel> homeCallListModels;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("data/homeCallList.json");
    Iterable<dynamic> json = jsonDecode(response);
    setState(() {
      homeCallListModels = List<HomeCallListModel>.from(
          json.map((model) => HomeCallListModel.fromJson(model)));
    });
  }

  @override
  initState() {
    super.initState();
    homeCallListModels = List<HomeCallListModel>.empty();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: homeCallListModels
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.call_received,
                        color: Colors.red,
                      ),
                      Text("(${v.times}) ${v.date}")
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
      ],
    );
  }
}

class HomeCallListModel {
  String name;
  String photo;
  int status;
  int times;
  String date;

  HomeCallListModel(this.name, this.photo, this.status, this.times, this.date);

  factory HomeCallListModel.fromJson(dynamic json) {
    return HomeCallListModel(json['name'] as String, json['photo'] as String,
        json['status'] as int, json['times'] as int, json['date'] as String);
  }
}
