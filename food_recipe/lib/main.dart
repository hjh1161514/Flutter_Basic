import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // 홈페이지 보여주기
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 음식 사진 데이터
    List<Map<String, dynamic>> dataList = [
      {
        "category": "수제버거",
        "imgUrl": "https://i.ibb.co/HBGKYn4/foodiesfeed-com-summer-juicy-beef-burger.jpg",
      },
      {
        "category": "건강식",
        "imgUrl": "https://i.ibb.co/mB5YNs2/foodiesfeed-com-pumpkin-soup-with-pumpkin-seeds-on-top.jpg",
      },
      {
        "category": "한식",
        "imgUrl": "https://i.ibb.co/Kzzpc97/Beautiful-vibrant-shot-of-traiditonal-Korean-meals.jpg",
      },
      {
        "category": "디저트",
        "imgUrl": "https://i.ibb.co/DL5vJVZ/foodiesfeed-com-carefully-putting-a-blackberry-on-tiramisu.jpg",
      },
      {
        "category": "피자",
        "imgUrl": "https://i.ibb.co/qsm8QH4/pizza.jpg",
      },
      {
        "category": "볶음밥",
        "imgUrl": "https://i.ibb.co/yQDkq2X/foodiesfeed-com-hot-shakshuka-in-a-cast-iron-pan.jpg",
      },
    ];

    // 화면에 보이는 영역
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Food Recipe",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                  CupertinoIcons.person,
                  color: Colors.black
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            // 상품 검색창
            child: TextField(
              decoration: InputDecoration(
                  labelText: "상품을 검색해주세요.",

                  // 테두리
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.grey
                      )
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                    "https://cdn.pixabay.com/photo/2016/11/18/15/03/burger-1835192_960_720.jpg",
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.fill
                ),
                Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5)
                ),
                Text(
                    "수제버거",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                )
            ]
            ),
          ),
        ],
      ),
    );
  }
}

class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}