import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {

  final _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _sizeController,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Adicionar", style: TextStyle(fontSize: 16.0),),
                textColor: Color.fromARGB(255, 240, 80, 83),
                onPressed: (){
                  Navigator.of(context).pop(_sizeController.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
