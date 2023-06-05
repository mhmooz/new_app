import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  late final WebViewController controller;
  final String url;
  // ignore: prefer_const_constructors_in_immutables
  WebViewScreen(this.url, {super.key});
  @override
  Widget build(BuildContext context) {
    controller = WebViewController()..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
