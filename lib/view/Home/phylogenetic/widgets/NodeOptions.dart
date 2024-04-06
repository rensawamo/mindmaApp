import 'package:flutter/material.dart';

import 'buttons/CreateBroButton.dart';
import 'buttons/CreateSonButton.dart';


class NodeOptions extends StatelessWidget {
  var createSon;
  var createBro;
  bool isFirst;

  NodeOptions(this.createSon, this.createBro, this.isFirst);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isFirst
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CreateSonButton(createSon)],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CreateSonButton(createSon),
                  SizedBox(width: 12),
                  CreateBroButton(createBro)
                ],
              ));
  }
}
