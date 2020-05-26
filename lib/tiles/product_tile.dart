import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/info_screen.dart';
import 'package:flutter_online_shop/data/product_data.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  ProductTile(this.type, this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>InfoScreen(data))
        );
      },
      child: Card(
          child: type == "grid"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        data.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              data.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ " + data.price.toStringAsFixed(2),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 90, 163),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Image.network(
                        data.images[0],
                        fit: BoxFit.cover,
                        height: 250.0,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ " + data.price.toStringAsFixed(2),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 90, 163),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
    );
  }
}
