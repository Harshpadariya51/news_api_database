import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/module/provider/news_provider.dart';

class detal_page extends StatelessWidget {
  final String url;
  detal_page({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Web View",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Consumer<newsprovider>(
          builder: (context, Newsprovider, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(url),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    Newsprovider.WebViewController(controller);
                  },
                ),
                Container(
                  color: const Color(0xffF2F2F2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Provider.of<newsprovider>(context, listen: false)
                              .goBack();
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<newsprovider>(context, listen: false)
                              .reloadWeb();
                        },
                        icon: const Icon(
                          Icons.refresh_outlined,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<newsprovider>(context, listen: false)
                              .goHome(url);
                        },
                        icon: const Icon(
                          Icons.home_outlined,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<newsprovider>(context, listen: false)
                              .goForward();
                        },
                        icon: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xffF2F2F2),
                                title: const Text("Add Favourite"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      onSubmitted: (val) {
                                        Newsprovider.textController.titleTxt;
                                      },
                                      controller:
                                          Newsprovider.textController.titleTxt,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: 'Name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        Provider.of<newsprovider>(context,
                                                listen: false)
                                            .addfavourite(url);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Done"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
