import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';

class AssegnazioneMassivaLista extends StatelessWidget {
  const AssegnazioneMassivaLista({ Key? key }) : super(key: key);

  final int elements = 32;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        //mainAxisSpacing: 3,
        //crossAxisSpacing: 3,
        childAspectRatio: 2.5
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Center(
            child: ListTile(
              leading: Checkbox(value: true, onChanged: (value){}),
              title: Text(mockName() + mockName(), style: TextStyle(fontSize: 14),),
              subtitle: Text("Padova Centro", style: TextStyle(fontSize: 14),),
            ),  
          ),
        );
      },
        childCount: elements
      ),
    );
  }
}