import 'dart:io';
import 'package:secondproject/src/battle.dart';

//사전 설정
String nameWhileRun = 'Y';

void gamestart() {
  // 한글과 영문만 허용
  String? characterName;
  RegExp nameRegExp = RegExp(r'^[a-zA-Z가-힣]+$');

  // 이름 입력 받기
  while (characterName == null || !nameRegExp.hasMatch(characterName)) {
    stdout.write('♦︎ 당신의 이름은 무엇인가요? ');
    characterName = stdin.readLineSync();

    // 다시 받기 : 빈 값 입력 시
    if (characterName == null || characterName.isEmpty) {
      print('♦︎ 이름을 입력해 주세요.');
      characterName = null;
    } 
    // 다시 받기 : 유효하지 않은 이름 입력 시
    else if (!nameRegExp.hasMatch(characterName)) {
      print('이름에는 한글 및 영문만 사용할 수 있습니다.');
      characterName = null;
    }
  }

  // 이름 확인 변수
  while (nameWhileRun == 'Y') {
    // 이름 확인하기
    print('♦︎ 당신의 이름은 $characterName(이)로군요.');
    stdout.write('♦︎ 맞습니까? Y/N ');
    String? nameCorrection = stdin.readLineSync();

    // Y/N 입력 처리
    if (nameCorrection != null && nameCorrection.toUpperCase() == 'Y') {
      nameWhileRun = 'N';  // 루프 종료
      sleep(Duration(milliseconds: 300));
      print('반갑습니다, $characterName님.');
      sleep(Duration(milliseconds: 300));
      battle(characterName);  // battle 함수 호출
    } 
    // 이름을 다시 입력 받기
    else if (nameCorrection != null && nameCorrection.toUpperCase() == 'N') {
      print('♦︎ 이름을 다시 입력해 주세요.');
      gamestart();
    } 
    // 잘못된 입력 처리
    else {
      print('♦︎ 잘못된 입력입니다. Y 또는 N을 입력해 주세요.');
    }
  }
}
