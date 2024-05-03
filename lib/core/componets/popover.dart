import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/buttons/edit_button.dart';
import 'package:mindmapapp/view/Home/phylogenetic/widgets/edit_list.dart';

class PopoverExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Popover Example')),
        body: Container(
            width: 40,
            height: 40,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  showPopover(
                    context: context,
                    bodyBuilder: (context) => const MyDropdownScreen(),
                    onPop: () => print('Popover was popped!'),
                    direction: PopoverDirection.bottom,
                    width: 200,  // ポップオーバーの幅を300に設定
                    height: 200,  // ポップオーバーの高さを400に設定
                    arrowHeight: 15,  // 矢印の高さ
                    arrowWidth: 30,  // 矢印の幅
                  );
                },
                child: const Text('Show Popover'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
