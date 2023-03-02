import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

/// 버킷 클래스 // HJ: data class
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자 //HJ: 호출시 job과 isDone을 받아 할당
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bucket> bucketList = []; // 전체 버킷리스트 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷 리스트"),
      ),
      body: bucketList.isEmpty
          ? Center(child: Text("버킷 리스트를 작성해 주세요.")) // true
          : ListView.builder(
              // false
              itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
              itemBuilder: (context, index) {
                // HJ: index는 0부터 length-1까지
                Bucket bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                return ListTile(
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket.job,
                    style: TextStyle(
                      fontSize: 24,
                      color: bucket.isDone ? Colors.grey : Colors.black,
                      decoration: bucket.isDone
                          ? TextDecoration.lineThrough // HJ: 가운데에 선을 긋는다
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      showDeleteDialog(context, index);
                    },
                  ),
                  onTap: () {
                    // 아이템(각 버킷리스트) 클릭시
                    setState(() {
                      bucket.isDone = !bucket.isDone;
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            // HJ: 언제 pop이 될 지 모르니 기다림
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );
          if (job != null) {
            setState(() {
              Bucket newBucket = Bucket(job, false); // HJ: 생성자 호출해서 인스턴스 만듦
              bucketList.add(newBucket);
            });
          }
        },
      ),
    );
  }

  showDeleteDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context); // HJ: 다이얼로그를 끌 때
              },
              child: Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                setState(() {
                  bucketList
                      .removeAt(index); // HJ: ListView builder에서 전달하는 index
                });
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error, // HJ: 값이 null이 되어야 error가 아닌 textField 상태가 됨
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      // 안에 상태 변경하는 코드
                      error = "내용을 입력해주세요.";
                    });
                  } else {
                    setState(() {
                      error = null;
                    });
                    // HJ: 화면 종료하기
                    Navigator.pop(context, job);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
