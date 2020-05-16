import 'package:flutter/material.dart';
import 'package:flutter_online_shop/data/product_data.dart';

class InfoScreen extends StatefulWidget {

  final ProductData data;

  InfoScreen(this.data);

  @override
  _InfoScreenState createState() => _InfoScreenState(data);
}

class _InfoScreenState extends State<InfoScreen> {

  final ProductData data;

  _InfoScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

