import 'package:flutter/material.dart';

import 'main.dart';

/// Bucket 담당
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false), // 더미(dummy) 데이터
  ];

  /// bucket 추가
  // HJ: create 관련 함수
  void createBucket(String job) {
    bucketList.add(Bucket(job, false));
    notifyListeners(); // HJ: ChangeNotifier의 기능. 변경사항이 있는 경우 새로고침
  }

  /// bucket 수정
  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  /// bucket 삭제
  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}