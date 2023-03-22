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
  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    context.select((NotificationsBloc bloc) => bloc.state.status);

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: WebView(
            initialUrl: 'https://www.solesteals.com${widget.path}',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
