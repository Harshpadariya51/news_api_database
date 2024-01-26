import 'package:flutter/material.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:quotes_api_app/view/detail_page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await APIHelper.apiHelper.fetchedQuote().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF24B4B),
          title: const Text(
            "News ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                shape: const OutlineInputBorder(),
                color: const Color(0xffF2F2F2),
                child: const Icon(Icons.favorite),
                itemBuilder: (context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text("Favourite"),
                      onTap: () {
                        Navigator.of(context).pushNamed("favourite_page");
                      },
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: FutureBuilder(
                  future: APIHelper.apiHelper.fetchedQuote(),
                  builder: (context, snapshot) {
                    List<News>? data;
                    (snapshot.hasError)
                        ? print(snapshot.error)
                        : snapshot.hasData
                            ? data = snapshot.data
                            : const CircularProgressIndicator();

                    return (data == null)
                        ? Container()
                        : GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: 5 / 4),
                            children: data
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              detal_page(url: e.url),
                                        ),
                                      );
                                      // Navigator.of(context).pushNamed(
                                      //     'detal_page',
                                      //     arguments: e);
                                    },
                                    child: Card(
                                      color: const Color(0xffF2F2F2),
                                      elevation: 10,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    e.name,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  Text(e.category),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    height: 2,
                                                    color: Colors.black26,
                                                  ),
                                                  Text(e.description),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffF24B4B),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    e.country,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
