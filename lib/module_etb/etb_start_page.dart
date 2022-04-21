import 'package:flutter/material.dart';

class ETBStartPage extends StatefulWidget {
  const ETBStartPage({ Key? key }) : super(key: key);

  @override
  State<ETBStartPage> createState() => _ETBStartPageState();
}

class _ETBStartPageState extends State<ETBStartPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title')),
      body: Text('Helllo its me'),
    );
  }
}