import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final int item;
  final String nama;
  const DetailPage({Key? key, required this.item, required this.nama})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<KarakterDetail> karDetail;

  @override
  void initState() {
    super.initState();
    karDetail = fetchDetails(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          widget.nama,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<KarakterDetail>(
          future: karDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(snapshot.data!.imgUrl),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data!.nama,
                  ),
                  Text(snapshot.data!.spesies),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      snapshot.data!.gender,
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}

class KarakterDetail {
  String imgUrl;
  String nama;
  String status;
  String spesies;
  String gender;
  int id;

  KarakterDetail(
      {required this.imgUrl,
      required this.nama,
      required this.status,
      required this.spesies,
      required this.gender,
      required this.id});

  factory KarakterDetail.fromJson(json) {
    return KarakterDetail(
        imgUrl: json['image_url'],
        nama: json['name'],
        status: json['status'],
        spesies: json['spesies'],
        gender: json['gender'],
        id: json['id']);
  }
}

Future<KarakterDetail> fetchDetails(id) async {
  var response = await http.get(
    Uri.parse('https://rickandmortyapi.com/api/character/$id'),
  );

  if (response.statusCode == 200) {
    return KarakterDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
