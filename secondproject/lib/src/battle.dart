import 'dart:io';
import 'dart:math';  // Random 클래스를 사용하기 위해 추가
import 'package:secondproject/src/tiltle.dart';

// 캐릭터 클래스 정의
class Character {
  String name;
  int health;
  final int attack;
  final int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) health = 0;  // 체력은 0 이상으로 유지
  }
}

// 몬스터 클래스 정의
class Monsters {
  final String name;
  int health;
  final int attack;
  final int defense;

  Monsters(this.name, this.health, this.attack, this.defense);

  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) health = 0;  // 체력은 0 이상으로 유지
  }
}

// 캐릭터 객체 선언
Character? character;

// 몬스터 리스트 선언
List<Monsters> monstersList = [];

// 캐릭터 파일 불러오기
void loadCharacterStats(String characterName) {
  try {
    final file = File('lib/src/stats/characters.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    character = Character(characterName, health, attack, defense);  // 캐릭터 이름 설정
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 몬스터 파일 불러오기
void loadMonstersStats() {
  try {
    final file = File('lib/src/stats/Monsters.txt');
    final lines = file.readAsLinesSync();

    for (var line in lines) {
      final stats = line.split(',');
      if (stats.length != 4) throw FormatException('Invalid monster data');

      String name = stats[0];
      int health = int.parse(stats[1]);
      int attack = int.parse(stats[2]);
      int defense = int.parse(stats[3]);

      // 몬스터 객체를 리스트에 추가
      monstersList.add(Monsters(name, health, attack, defense));
    }
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 배틀 함수
void battle(String characterName) {
  loadMonstersStats();  // 몬스터 정보를 먼저 불러오기
  bar();

  if (character == null) {
    print("캐릭터가 초기화되지 않았습니다.");
    exit(1);
  }

  print('''$characterName(는)은 숲 속을 걷고 있습니다.
향긋한 풀냄새와 지저귀는 새소리가 평화롭군요.''');
  sleep(Duration(milliseconds: 500));
  print('.');
  sleep(Duration(milliseconds: 500));
  print('.');
  sleep(Duration(milliseconds: 500));
  print('.');
  sleep(Duration(milliseconds: 500));
  print('''앗! 산적 무리가 습격 해옵니다.
당신은 포위되어 도망칠 수 없습니다.''');
  bar();
  sleep(Duration(milliseconds: 300));

  // 첫 번째 몬스터 등장
  if (monstersList.isNotEmpty) {
    firstBattle();
  } else {
    print('몬스터 데이터가 없습니다.');
  }
}

/// 첫 번째 배틀 함수
void firstBattle() {
  Monsters firstMonster = monstersList[0];

  print('${firstMonster.name}');
  print('"훗, 훗, 훗. 산에서 산 지 15년... 너 같은 건 한 입거리도 안 될 것 같군."');
  print('♦︎ 그의 몸이 벌벌 떨리고 있다...');
  
  print('상대 체력: ${firstMonster.health}, 상대 공격력: ${firstMonster.attack}, 상대 방어력: ${firstMonster.defense}');

  print('당신은 ${character!.health}만큼의 체력이 남아있군요.');

  // 배틀 시작
  while (character!.health > 0 && firstMonster.health > 0) {
    
    // 상대방 턴  
    print('♦︎ ${firstMonster.name}의 턴!');
    print('"받아라!"');

    // 상대방 턴 랜덤 데미지 생성
    int damageOpp = Random().nextInt(firstMonster.attack + 1);  // 0 ~ firstMonster.attack 사이의 랜덤 데미지 생성
    character!.takeDamage(damageOpp);
  
    // 상대방 턴 데미지 출력
    print('♦︎ ${firstMonster.name}가 ${character!.name}에게 $damageOpp 데미지를 입혔습니다!');
    print('♦︎ ${character!.name}의 남은 체력: ${character!.health}');

    if (character!.health <= 0) {
      print('${character!.name}가 쓰러졌습니다...');
      break;
    }

    // 플레이어 턴  
    print('♦︎ ${character!.name}의 턴!');
    stdout.write('''♦︎ 어떤 행동을 취하시겠습니까? 
    [1] 공격하기
    [2] 방어하기: ''');
    
    String? playerAction = stdin.readLineSync();
    
    switch (playerAction) {
      case '1': 
        print('♦︎ 당신은 칼을 휘둘렀다.');

        // 플레이어 턴 랜덤 데미지 생성
        int damagePl = Random().nextInt(character!.attack + 1); 
        firstMonster.takeDamage(damagePl);
    
        // 플레이어 턴 데미지 출력
        print('♦︎ ${character!.name}가 ${firstMonster.name}에게 $damagePl 데미지를 입혔습니다!');
        print('♦︎ ${firstMonster.name}의 남은 체력: ${firstMonster.health}');
        break;

      case '2': 
        if (character!.defense >= firstMonster.attack) {
          print('♦︎ 당신은 방어에 성공했다.');
        } else {
          print('♦︎ 당신은 방어에 실패했다.');
          // 방어 실패 시 상대의 데미지 받기
          int damageOpp = Random().nextInt(firstMonster.attack + 1);
          character!.takeDamage(damageOpp);
          
          print('♦︎ ${firstMonster.name}가 ${character!.name}에게 $damageOpp 데미지를 입혔습니다!');
          print('♦︎ ${character!.name}의 남은 체력: ${character!.health}');
        }
        break;
      
      default:
        print('올바른 선택을 해주세요.');
        break;
    }

    if (firstMonster.health <= 0) {
      print('${firstMonster.name}가 쓰러졌습니다...');
      break;
    }
  }
}
