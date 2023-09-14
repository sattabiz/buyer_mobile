// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'index.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         const Duration(seconds: 1),
//         () => Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => const Index()))
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).colorScheme.secondary,
//       alignment: Alignment.center,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             "assets/splash_logo.svg",
//             width: 100,
//             height: 100,
//           ),
//           const SizedBox(height: 20),
//           SvgPicture.asset(
//             "assets/palet_point.svg",
//             // width: 100,
//             // height: 100,
//           ),
//         ],
//       ),
//     );
//   }
// }
