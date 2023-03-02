import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global =
      NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록
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
        "imgUrl": "https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_960_720.jpg",
      },
      {
        "category": "건강식",
        "imgUrl": "https://cdn.pixabay.com/photo/2022/12/09/02/13/korean-7644379_960_720.jpg",
      },
      {
        "category": "한식",
        "imgUrl": "https://cdn.pixabay.com/photo/2017/08/08/09/44/food-photography-2610863_960_720.jpg",
      },
      {
        "category": "디저트",
        "imgUrl": "https://cdn.pixabay.com/photo/2018/05/01/18/21/eclair-3366430_960_720.jpg",
      },
      {
        "category": "피자",
        "imgUrl": "https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_960_720.jpg",
      },
      {
        "category": "볶음밥",
        "imgUrl": "https://cdn.pixabay.com/photo/2016/10/23/09/37/fried-rice-1762493_960_720.jpg",
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

          Divider(height: 1),

          Expanded(child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                          dataList[index]["imgUrl"],
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
                        dataList[index]["category"],
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                    ]
                ),
              );
            },
          ))
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