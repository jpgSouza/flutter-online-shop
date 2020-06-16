import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/images_source.dart';

class ImagesWidget extends FormField<List> {

  ImagesWidget({
    BuildContext context,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    List initialValue,
    bool autoValidate = false,
  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidate: autoValidate,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 125,
              padding: EdgeInsets.all(16.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.value.map<Widget>((image) {
                  return Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 4.0),
                    child: GestureDetector(
                      child: image is String ? Image.network(image,
                          fit: BoxFit.cover) : Image.file(image,
                        fit: BoxFit.cover,),
                      onLongPress: () {
                        state.didChange(state.value..remove(image));
                      },
                    ),
                  );
                }).toList()
                  ..add(
                      GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Icon(
                            Icons.add_photo_alternate, color: Colors.white,),
                          color: Colors.white.withAlpha(50),
                        ),
                        onTap: () {
                          showModalBottomSheet(context: context,
                              builder: (context) =>
                                  ImageSourceSheet(onImageSelected: (image) {
                                    state.didChange(state.value..add(image));
                                    Navigator.of(context).pop();
                                  },));
                        },
                      )
                  ),
              ),
            ),
            state.hasError ? Text(
              state.errorText,
              style: TextStyle(color: Colors.redAccent, fontSize: 12.0),
            ) : Container()
          ],
        );
      }
  );

}
