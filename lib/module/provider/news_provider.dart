import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:quotes_api_app/module/models/news_model.dart';

class newsprovider extends ChangeNotifier {
  late InAppWebViewController _webViewController;

  List<Favouritemodel> favourite = [];

  TextControllerModel textController = TextControllerModel(
    titleTxt: TextEditingController(text: ""),
  );

  void addfavourite(String url) {
    favourite
        .add(Favouritemodel(title: textController.titleTxt.text, url: url));
    notifyListeners();
    textController.titleTxt.clear();
  }

  void WebViewController(InAppWebViewController controller) {
    _webViewController = controller;
  }

  void setWebViewController(InAppWebViewController controller) {
    _webViewController = controller;
  }

  void reloadWeb() {
    if (_webViewController != null) {
      _webViewController.reload();
    }
  }

  void goBack() {
    if (_webViewController != null) {
      _webViewController.goBack();
    }
  }

  void goHome(String url) {
    _webViewController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(url),
      ),
    );
  }

  void goForward() {
    if (_webViewController != null) {
      _webViewController.goForward();
    }
  }
}
