import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api/getNews.dart';
import '../../Api/linkapi.dart';
import '../../Constant/const.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColorAppBar,
          title: Center(
            child: Text(
              "نشرة الأخبار",
              style: GoogleFonts.acme(
                textStyle: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        body: FutureBuilder(
          future: getData(linkApi),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.network(
                              '${snapshot.data?["articles"][index]["urlToImage"]}',
                              fit: BoxFit.contain,
                              alignment: Alignment.topCenter,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 7, top: 5, left: 4),
                              child: InkWell(
                                onTap: () async {
                                  Uri url = Uri.parse(
                                      '${snapshot.data["articles"][index]["url"]}');

                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  '${snapshot.data?["articles"][index]["title"]}',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Color.fromARGB(255, 26, 76, 214),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 7, top: 5, bottom: 7),
                              child: Text(
                                '${snapshot.data?["articles"][index]["description"]}',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ]),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
