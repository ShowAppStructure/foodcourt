import 'package:flutter/material.dart';
import 'package:foodcourt/utils/ScrollClass.dart';
import 'package:foodcourt/utils/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'FoodCourt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentPage = 0;
  PageController _pageController = PageController(viewportFraction: 0.3);

  void _foodControllerListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_foodControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_foodControllerListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 100,
              child: Container(
                color: Colors.red,
              )),
          PageView.builder(
            controller: _pageController,
            itemCount: foods.length+1 ,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {

              if (index ==0) return SizedBox.shrink();
              final food = foods[index -1];
              final result = _currentPage - index +1;
              print("_currentPage: ${_currentPage} - index: ${index} +1 = ${result}" );
              final value = -0.3 * result  +1;

              print("height/3: ${MediaQuery.of(context).size.height / 3} - (1 - value): ${(1 - value).abs()}" );
                return Transform(
                // alignment: Alignment.bottomCenter,
                // alignment: FractionalOffset.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0001)
                  ..translate(
                    0.0,
                    MediaQuery.of(context).size.height / 3* (1 - value).abs(),
                  )
                  ..scale(value)
                  ,
                child: Image.asset(food.imagePath),
              );
            },
          )
        ],
      ),
    );
  }
}
