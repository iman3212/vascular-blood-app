// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class StepesView extends StatefulWidget {
//   final List<String>? list;
//   final String? index;
//   final Function(String)? callback;

//   const StepesView({super.key, this.list, this.index, this.callback});

//   @override
//   _StepesViewState createState() => _StepesViewState();
// }

// class _StepesViewState extends State<StepesView> {
//   String? _selectedIndex;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.index != null) {
//       _selectedIndex = widget.index;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: widget.list?.length ?? 0,
//       itemBuilder: (context, index) {
//         return fourChoiceItem(widget.list![index]);
//       },
//     );
//   }

//   Widget fourChoiceItem(String title) {
//     return ChoiceChip(
//       padding: const EdgeInsets.all(5),
//       selected: _selectedIndex == title,
//       label: Container(
//         width: double.infinity,
//         alignment: Alignment.centerLeft,
//         height: 30,
//         child: Text(
//           title,
//           style: TextStyle(
//             fontWeight:
//                 _selectedIndex == title ? FontWeight.bold : FontWeight.normal,
//             color: _selectedIndex == title ? Colors.white : Colors.grey,
//           ),
//         ),
//       ),
//       avatar: _selectedIndex == title
//           ? const Icon(Icons.check_circle, color: Colors.white)
//           : const Icon(CupertinoIcons.circle, color: Colors.grey),
//       pressElevation: 5,
//       shape: const RoundedRectangleBorder(
//         side: BorderSide(
//           width: 0.5,
//           color: Colors.grey,
//         ),
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//       ),
//       backgroundColor: Colors.white,
//       selectedColor: Colors.black,
//       onSelected: (bool selected) {
//         setState(() {
//           if (selected) {
//             _selectedIndex = title;
//             widget.callback?.call(_selectedIndex!);
//           }
//         });
//       },
//     );
//   }
// }