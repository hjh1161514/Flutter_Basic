import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    required this.imageUrl, // feed 클래스 호출 (=생성자 호출)시 imageUrl을 할당
  }) : super(key: key);

  final String imageUrl; //이미지를 담을 변수

  @override
  State<Feed> createState() => _FeedState();
}

// _는 private 함수로 외부에서 접근이 불가능.
// 외부에서 전달받은 변수인 imageUrl을 위에 있는 class에서 사용해야 함
class _FeedState extends State<Feed> {

  // 좋아요 상태 관리
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
      children: [
        // 이미지
        Image.network(
          widget.imageUrl,
          height: 400,
          width: double.infinity, // 부모에서 넣을 수 있는 최대 크기
          fit: BoxFit.cover, // scaleType과 비슷
        ),
        // 아이콘
        Row(
          children: [
            IconButton(
              onPressed: () {
                // setState: 화면 갱신
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                CupertinoIcons.heart,
                color: isFavorite? Colors.pink : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            Spacer(), // 빈 공간 추가 - 커질 수 있을만큼 최대한 커짐
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
          ],
        ),

        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),

        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBURARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}