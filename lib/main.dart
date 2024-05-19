import 'package:flutter/material.dart';

import 'Screens/Homepage.dart';

void main() {
  //this function starts the program and flutter does not allow us to write any program without the main() function
  runApp(const MyApp());
  // and the runapp is called inside the main function,
  // using runapp , you are able to return the widget that are connected to the screen ad a root of the widget tree ,that will ender the screen
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
