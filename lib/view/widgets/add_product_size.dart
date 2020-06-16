import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/add_size_dialog.dart';

class ProductsSizes extends FormField<List> {
  ProductsSizes({
    BuildContext context,
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      builder: (state) {
          return SizedBox(
            height: 34,
            child: GridView(
              padding: EdgeInsets.symmetric(vertical: 4),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.5),
              children: state.value.map((strings) {
                return GestureDetector(
                  onLongPress: () {
                    state.didChange(state.value..remove(strings));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: Color.fromARGB(255, 240, 80, 83), width: 2)),
                    alignment: Alignment.center,
                    child: Text(
                      strings,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList()
                ..add(GestureDetector(
                  onTap: () async{
                    String size = await showDialog(context: context, builder: (context) =>AddSizeDialog());
                    if(size != null){
                      state.didChange(state.value..add(size));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: Color.fromARGB(255, 240, 80, 83), width: 2)),
                    alignment: Alignment.center,
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            ),
          );
        });
}
