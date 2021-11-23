import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/pages/detail.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  late Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 20),
              child: Text(
                'CHARACTER',
                style: TextStyle(
                    color: Colors.black, letterSpacing: .5, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                child: FutureBuilder<List<Show>>(
                    future: shows,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                            leading: Image.network(
                              snapshot.data![index].imgUrl,
                            ),
                            title: Text(
                              snapshot.data![index].nama,
                              style: GoogleFonts.ubuntu(),
                            ),
                            subtitle: Text(
                              snapshot.data![index].status,
                              style: GoogleFonts.ubuntu(),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    nama: snapshot.data![index].nama,
                                    item: snapshot.data![index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Show {
  final int id;
  final String nama;
  final String imgUrl;
  final String status;

  Show({
    required this.id,
    required this.nama,
    required this.imgUrl,
    required this.status,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      nama: json['name'],
      imgUrl: json['image'],
      status: json['status'],
    );
  }
}

// function untuk fetch api
Future<List<Show>> fetchShows() async {
  String api = 'https://rickandmortyapi.com/api/character/';
  final response = await http.get(
    Uri.parse(api),
  );

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['results'] as List;

    return topShowsJson.map((shows) => Show.fromJson(shows)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
