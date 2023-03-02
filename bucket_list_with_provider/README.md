# 버킷리스트 with Provider

Flutter와 Provider를 이용한 버킷리스트 만들기

## 구현 기능

- 아래 모든 기능은 Provider를 적용해 구현
- 리스트 조회
    - 리스트가 없을 경우 empty 뷰
    - 리스트가 있으면 내용과 삭제 버튼이 함께 나타남
- 리스트 추가
    - 텍스트 값이 없는 상태로 '추가하기' 버튼을 누르면 에러 메세지가 나타남
- 리스트 수정
    - 리스트를 클릭하면 완료 표시(회색 글씨, 중앙선)가 나타남
- 리스트 삭제
    - 휴지통 버튼을 누르면 리스트가 삭제됨

## 실행 화면
![img초기](https://user-images.githubusercontent.com/61824695/222315849-3b3d76f5-bd3b-4817-ba30-234f4586bd03.png)
![img작성](https://user-images.githubusercontent.com/61824695/222315853-0024203b-f4a5-4601-b29e-8c7a0a7ed920.png)
![img작성에러](https://user-images.githubusercontent.com/61824695/222315862-60863e5f-57f9-4924-b2bf-05093cf73c89.png)
![img조회](https://user-images.githubusercontent.com/61824695/222315868-08831ee9-0f31-4b05-b567-bdcc5134e0ea.png)
![img수정](https://user-images.githubusercontent.com/61824695/222315876-51453c59-3830-4734-8dff-e3fc8d08f7cf.png)