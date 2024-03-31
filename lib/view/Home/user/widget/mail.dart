import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';


class MyApps extends StatelessWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            FilledButton(
              onPressed: openPhoneCall,
              child: Text('call'),
            ),
            FilledButton(
              onPressed: openEmail,
              child: Text('email'),
            ),
            FilledButton(
              onPressed: _callNumber,
              child: Text('call'),
            ),
          ],
        );
  }

  void openPhoneCall() async {
    final Uri callLaunchUri = Uri(
      scheme: 'tel',
      path: '117',
    );

    canLaunchUrl(callLaunchUri).then((value) {
      if (value) {
        launchUrl(callLaunchUri).then((value) {
          print('launchUrl result: $value');
        });
      } else {
        print('cannot call');
      }
    });
  }

  void openEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'testtest@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'It is subject',
        'body': 'It is message',
      }),
    );

    canLaunchUrl(emailLaunchUri).then((value) {
      if (value) {
        launchUrl(emailLaunchUri).then((value) {
          print('launchUrl result: $value');
        });
      } else {
        print('cannot call');
      }
    });
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<bool?> _callNumber() {
    const number = '117'; //set the number here
    return FlutterPhoneDirectCaller.callNumber(number);
  }
}