import 'dart:io';

void exitGame (bar,titleSelection,title) {
while(titleSelection == '3'){
//게임 종료 여부 묻기
stdout.write('♦︎ 게임을 종료하시겠습니까? ');
     String? ifexitGame = stdin.readLineSync();
     
//게임 종료
     if (ifexitGame != null && ifexitGame.toUpperCase() == 'Y') {
     sleep(Duration(milliseconds: 200));
     print('♦︎ 당신의 여정은 계속될 것입니다...');
     sleep(Duration(seconds: 1));
     exit(0);}

//게임 종료 입력 오류
     else if
     (ifexitGame == null || !RegExp(r'^[a-zA-Z]$').hasMatch(ifexitGame))
     {
     sleep(Duration(milliseconds: 200));
     bar();
     print('♦︎ 영문을 입력해 주세요. ♦︎');
     bar();
     }

//타이틀로 돌아가기
     else {
        sleep(Duration(milliseconds: 500));
        bar();
        print('♦︎ 타이틀로 돌아갑니다. ♦︎');
        sleep(Duration(milliseconds: 500));
        titleSelection = '0';
        title();
        }
     }
}