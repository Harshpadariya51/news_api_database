import 'package:flutter/material.dart';
import 'package:quotes_api_app/module/helper/api_helper.dart';
import 'package:quotes_api_app/module/helper/database_helper.dart';
import 'package:quotes_api_app/module/models/news_model.dart';
import 'package:quotes_api_app/module/view/detail_page.dart';

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
          backgroundColor: Colors.blue,
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
          // leading: Drawer(),
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
                                    mainAxisSpacing: 9,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: 6 / 4),
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
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Name : ${e.name}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                          'Category : ${e.category}'),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(8),
                                                        height: 2,
                                                        color: Colors.black26,
                                                      ),
                                                      const Text(
                                                        "Description",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
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
                                                            fontSize: 13,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            // Add item to the database
                                            await DatabaseHelper()
                                                .insertFavorite({
                                              DatabaseHelper.columnName: e.name,
                                              // Add other columns as needed
                                            });

                                            // Navigate to the details page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    detal_page(url: e.url),
                                              ),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.favorite_border),
                                        ),
                                      ],
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
