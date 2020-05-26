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
          backgroundColor: Color.fromARGB(255, 0, 90, 163),
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: data.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: Color.fromARGB(255, 0, 90, 163),
                autoplay: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    data.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  Text(
                    "R\$" + data.price.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 90, 163)),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Tamanho",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34.0,
                    child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: sizes == size
                                      ? Color.fromARGB(255, 0, 90, 163)
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
                      child: Text(
                        "Adicionar ao Carrinho",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      color: Color.fromARGB(255, 0, 90, 163),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Descrição",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    data.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
