import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solesteals/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String path;
  const HomeScreen({super.key, required this.path});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController _controllerGlobal;

  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().requestPermission();
  }

  Future<bool> _exitApp(BuildContext context) async {
    print('TESTTESTETST');
    if (Platform.isIOS) return Future.value(false);

    if (await _controllerGlobal.canGoBack()) {
      _controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.select((NotificationsBloc bloc) => bloc.state.status);

    Widget homeWebView() {
      return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: WebView(
              onWebViewCreated: (WebViewController controller) {
                _controllerGlobal = controller;
              },
              initialUrl: 'https://www.solesteals.com${widget.path}',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      );
    }

    if (Platform.isIOS) {
      return Scaffold(
        body: GestureDetector(
          onHorizontalDragStart: (details) {
            if (details.localPosition.dx > 50) return;
            _controllerGlobal.goBack();
          },
          child: homeWebView(),
        ),
      );
    }

    return Scaffold(
      body: homeWebView(),
    );
  }
}
