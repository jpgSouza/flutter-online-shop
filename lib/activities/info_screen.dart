import 'package:carousel_pro/carousel_pro.dart';
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

  String size;

  _InfoScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data.title),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.9,
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.0,
                child: Stack(
                  children: <Widget>[
                    Carousel(
                      images: data.images.map((url) {
                        return NetworkImage(url);
                      }).toList(),
                      dotSize: 6.0,
                      dotSpacing: 16.0,
                      dotBgColor: Colors.transparent,
                      dotColor: Color.fromRGBO(240, 80, 83, 0.7),
                      autoplay: false,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              blurRadius: 10.0,
                              offset: Offset(0, 3)
                          )
                        ],
                      color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        border: Border.all(color: Colors.grey[500])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                          maxLines: 3,
                        ),
                        Text(
                          "R\$" + data.price.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Tamanho",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 34.0,
                          child: GridView(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.5),
                            children: data.sizes.map((sizes) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    size = sizes;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(34.0)),
                                    border: Border.all(
                                        color: sizes == size
                                            ? Color.fromARGB(255, 240, 80, 83)
                                            : Colors.grey,
                                        width: 2.0),
                                  ),
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: Text(sizes),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: 44.0,
                          child: RaisedButton(
                            onPressed: size != null ? () {} : null,
                            color: Color.fromARGB(255, 0, 90, 163),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 253, 228),
                                        Color.fromARGB(255, 240, 80, 83),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 400.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Adicionar ao carrinho",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Descrição",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.description,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
