import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.HOME);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.HOME);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: _primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        flexibleSpace: SafeArea(child: _buildAppBar()),
      ),
      body: WebView(
        initialUrl: _args["url"],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: 32,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  color: _secondaryColor,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Image.asset(
                      'assets/images/icon/onlybunny.png',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
