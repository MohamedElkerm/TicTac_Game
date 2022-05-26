import 'package:flutter/material.dart';
import 'package:project/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  bool gameOver = false;

  //turn => Total of Moves
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child:MediaQuery.of(context).orientation == Orientation.portrait? Column(
          children: [
            ...firstBlock(),
            _expanded(context),
            ...lastBlock(),
          ],
        ):Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...firstBlock(),
                  ...lastBlock(),
                ],
              ),
            ),
            _expanded(context),
          ],
        ),
      ),
    );
  }


  List<Widget>firstBlock(){
    return[
      SwitchListTile.adaptive(
        value: isSwitched,
        onChanged: (newvalue) {
          setState(() {
            isSwitched = newvalue;
          });
        },
        title: const Text(
          'Two players',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Aynha',
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Text(
        'It\'s $activePlayer turn'.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontFamily: 'Aynha',
        ),
        textAlign: TextAlign.center,
      )
    ];
  }

  List<Widget> lastBlock(){
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontFamily: 'Aynha',
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX=[];
            Player.playerY=[];
            activePlayer = 'X';
            gameOver = false;
            turn = 0;
            result = '';
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text(
          'Repeat the game',
          style: TextStyle(fontFamily: 'Aynha', fontSize: 48),
        ),
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      )
    ];
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: gameOver ? null : () => _onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                          Player.playerX.contains(index)?'X':Player.playerY.contains(index)?'O':'',
                          style: TextStyle(
                          color:Player.playerX.contains(index)?Colors.blue:Colors.red,
                          fontSize: 52,
                          fontFamily: 'Aynha'
                          ),
                    )),
                  ),
                ),
              ),
            ),
          );
  }

  _onTap(int index) async{

    if((Player.playerX.isEmpty||!Player.playerX.contains(index))&&(Player.playerY.isEmpty||!Player.playerY.contains(index))){
      game.playGame(index, activePlayer);
      updateState();
      if(isSwitched == false && gameOver == false){
        await game.autoPlay(activePlayer);
        updateState();
      }
    }

  }

  void updateState() {
    setState((){
      activePlayer = activePlayer=='X'?'O':'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if(winnerPlayer != ''){
        gameOver = true;
        result = '$winnerPlayer is the Winner';
      }else if(!gameOver && turn == 9) {
        result = 'It\'s Draw';
      }
    });
  }
}
