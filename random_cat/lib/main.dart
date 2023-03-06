import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록
  runApp(
    MultiProvider( // HJ: 위젯트리 최상단에서 provider 사용
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()), // HJ: CatService를 위젯트리 꼭대기에 주입
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 고양이 서비스
class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  // 좋아요 사진
  List<String> favoriteImages = [];

  // 생성자에서 함수 호출
  CatService() {
    getRandomCatImages();
  }

  // 랜덤 고양이 사진 API 호출
  void getRandomCatImages() async {
    Response result = await Dio().get(
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg"
    );
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map["url"]);
      catImages.add(map["url"]);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); // 이미 좋아요한 경우 삭제
    } else {
      favoriteImages.add(catImage); // 추가
    }

    notifyListeners(); // HJ: Consumer 아래에 있는 builder 부분이 다시 실행되면서 갱신
  }
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>( // HJ: Consumer: 위젯 트리 꼭대기에서 CatService를 찾아서 두 번째 인스턴스로 전달
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("랜덤 고양이"),
            backgroundColor: Colors.amber,
            actions: [
              // 좋아요 페이지로 이동
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              )
            ],
          ),
          // 고양이 사진 목록
          body: GridView.count( // HJ: GridView는 타일 형태의 layout을 만들 때 사용
            mainAxisSpacing: 8, // HJ: 타일 간의 간격
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2, // HJ: 줄
            children: List.generate(
              catService.catImages.length, // HJ: 배열 원소 개수
                (index) { // HJ: 익명 함수가 반복
                String catImage = catService.catImages[index];
                return GestureDetector( // HJ: 클릭 이벤트를 추가하기 위해 사용하는 위젯
                  onTap: () {
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Stack( // HJ: Stack은 기본적으로 화면을 꽉 채우지 않음
                    children: [
                      Positioned.fill( // HJ: Positioned는 상하좌우 간격을 주는 위젯. fill을 사용하면 모든 상하좌우를 0으로. = 꽉 채운다
                        child: Image.network(
                            catImage,
                            fit: BoxFit.cover
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(
                            Icons.favorite,
                            color: catService.favoriteImages.contains(catImage)
                                ? Colors.amber
                                : Colors.transparent
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("좋아요"),
            backgroundColor: Colors.amber,
          ),
          body: GridView.count( // HJ: GridView는 타일 형태의 layout을 만들 때 사용
            mainAxisSpacing: 8, // HJ: 타일 간의 간격
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2, // HJ: 줄
            children: List.generate(
              catService.favoriteImages.length, // HJ: 배열 원소 개수
                  (index) { // HJ: 익명 함수가 반복
                String catImage = catService.favoriteImages[index];
                return GestureDetector( // HJ: 클릭 이벤트를 추가하기 위해 사용하는 위젯
                  onTap: () {
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Stack( // HJ: Stack은 기본적으로 화면을 꽉 채우지 않음
                    children: [
                      Positioned.fill( // HJ: Positioned는 상하좌우 간격을 주는 위젯. fill을 사용하면 모든 상하좌우를 0으로. = 꽉 채운다
                        child: Image.network(
                            catImage,
                            fit: BoxFit.cover
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(
                            Icons.favorite,
                            color: catService.favoriteImages.contains(catImage)
                                ? Colors.amber
                                : Colors.transparent
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
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