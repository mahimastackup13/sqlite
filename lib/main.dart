import 'package:flutter/material.dart';
import 'package:flutter_sqfite/contact_list_screen.dart';
import 'package:provider/provider.dart';
import 'state_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContactManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ContactListScreen(),
    );
  }
}
