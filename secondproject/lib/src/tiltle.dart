import 'dart:io';

import 'package:secondproject/src/gameexit.dart';
import 'package:secondproject/src/newgame.dart';

//사전 설정
void bar() {
String bartxt = '=======================';
print(bartxt);
  }
String titleSelection = '0';

// 타이틀 구성
void title() {
  bar();
  print('''
  [1] 처음부터 시작하기
  [2] 세이브 파일 불러오기
  [3] 게임 종료하기''');
  bar();
}

// 새 게임 시작
void newGame() {
      // 게임 시작 안내
  bar();
  print('♦︎ 새 게임을 시작합니다. ♦︎');
  bar();
  sleep(Duration(milliseconds: 300));
  print('Loading.');
  sleep(Duration(milliseconds: 300));
  print('Loading..');
  sleep(Duration(milliseconds: 300));
  print('Loading...');
  sleep(Duration(milliseconds: 300));
  gamestart();
}

void titlectrl() {
   
// 사용자 입력 요청
  while(titleSelection == '0') {
  stdout.write('♦︎ 이용하실 메뉴의 번호를 입력하세요 ');
  String? titleSelection = stdin.readLineSync();

//사용자 입력 처리
  switch(titleSelection) {
    case '1':
    newGame();
    break;

    case '2':
    print('♦︎저장된 파일을 불러옵니다. ♦︎');
    break;

//프로그램 종료
    case '3':
     exitGame(bar, titleSelection, title);
    break;


  }
}
}