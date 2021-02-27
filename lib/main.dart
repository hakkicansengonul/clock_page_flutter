import 'package:clock_page_flutter_app/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<String>> products = [
    [
      "https://cdn.pixabay.com/photo/2015/06/25/17/22/smart-watch-821559_1280.jpg",
      "Hugo Boss Oxygen",
      "100 \$"
    ],
    [
      "https://cdn.pixabay.com/photo/2016/01/19/17/22/wristwatch-1149669_1280.jpg",
      "Hugo Boss Signature",
      "120 \$"
    ],
    [
      "https://cdn.pixabay.com/photo/2016/02/18/22/15/watch-1208200_1280.jpg",
      "Casio G-Shock Premium",
      "80 \$"
    ]
  ];
  int currentIndex = 0;
  void _next() {
    setState(() {
      if (currentIndex < products.length - 1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _preve();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _next();
                }
              },
              child: Container(
                width: double.infinity,
                height: 550.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(products[currentIndex][0]),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                        Colors.grey[700].withOpacity(.9),
                        Colors.grey.withOpacity(.0)
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        margin: EdgeInsets.only(bottom: 60.0),
                        child: Row(
                          children: _buildIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Transform.translate(
              offset: Offset(0, -40),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        products[currentIndex][1],
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: [
                        FadeAnimation(
                          1.4,
                          Text(
                            products[currentIndex][2],
                            style: TextStyle(
                                color: Colors.yellow[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        FadeAnimation(
                          1.5,
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.yellow[700],
                              ),
                              Icon(
                                Icons.star_half,
                                size: 18.0,
                                color: Colors.yellow[700],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "(4.2/70 reviews)",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FadeAnimation(
                          1.7,
                          Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                "ADD TO CART",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
        child: Container(
      height: 4,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: isActive ? Colors.grey[800] : Colors.white,
      ),
    ));
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < products.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
