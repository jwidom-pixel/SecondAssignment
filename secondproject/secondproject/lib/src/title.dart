//사전 설정
import 'dart:io';

import 'package:secondproject/src/gameexit.dart';
import 'package:secondproject/src/newgame.dart';

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

void loadGameResults() {
  try {
    // 파일 경로 설정
    File file = File('lib/src/stats/SaveResults.txt');

    // 파일이 존재하는지 확인
    if (!file.existsSync()) {
      print('저장된 게임 결과가 없습니다.');
      return;
    }

    // 파일 내용 읽기
    List<String> lines = file.readAsLinesSync();

    if (lines.isEmpty) {
      print('저장된 게임 결과가 없습니다.');
    } else {
      print('저장된 게임 결과:');
      for (var line in lines) {
        print(line);
      }
    }
  } catch (e) {
    print('게임 결과를 불러오는 데 실패했습니다: $e');
  }
}
    break;

//프로그램 종료
    case '3':
     exitGame(bar,titleSelection, title);
    break;


  }
}
}