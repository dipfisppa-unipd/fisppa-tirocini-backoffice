import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';

class GridElement extends StatelessWidget {
  const GridElement({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Checkbox(value: true, onChanged: (value){}),
        title: Text(mockName() + mockName()),
        subtitle: Text("Padova Centro"),
      ),  
    );
  }
}