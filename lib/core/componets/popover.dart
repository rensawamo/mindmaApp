// import 'package:flutter/material.dart';
// import 'package:popover/popover.dart';
// import 'package:mindmapapp/view/Home/phylogenetic/widgets/edit_list.dart';

// class PopoverExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Popover Example')),
//         body: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   showPopover(
//                     context: context,
//                     bodyBuilder: (context) => MyDropdownScreen(),
//                     onPop: () => print('Popover was popped!'),
//                     direction: PopoverDirection.bottom,
//                     arrowHeight: 15,
//                     arrowWidth: 30,
//                   );
//                 },
//                 child: const Text('Show Popover'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
