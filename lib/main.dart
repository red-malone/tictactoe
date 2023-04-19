import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TICTACTOE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TICTACTOE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _scoreX=0;
  int _scoreY=0;
  bool _turnO=false;
  int _filled=0;
  final List<String> _xolist=['','','','','','','','',''];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TICTACTOE"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed:(){
                _clearBoard();
                },
              icon: Icon(Icons.fiber_new_rounded)),
          IconButton(onPressed: (){
            _clearStateBoard();
          }, icon:Icon(Icons.refresh_sharp))
          
        ],
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            _score(),
            _grid(),
            _turn(),
          ],
        ),
      ),
    );

  }

  Widget _score(){
    return Expanded(
      flex: 0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Player X',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w800),),
                    SizedBox(height: 2),
                    Text(_scoreX.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                  ],
                ),

              ),
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Player O',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w800),),
                    SizedBox(height: 2),
                    Text(_scoreY.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                  ],
                ),

              ),




            ],
          ),
        ),
    );
  }
  Widget _grid(){
    return Expanded(
      flex: 4,
        child:GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:3 ),
            itemBuilder:(BuildContext context,int index){
              return GestureDetector(
                onTap:(){
                  _tapped(index);
                },
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      _xolist[index],style: TextStyle(
                      color: _xolist[index] =='x' ? Colors.amber : Colors.blue,
                      fontSize: 36,
                    ),
                    ),
                  ),

                ),
              );
            }

        ),
    );
  }
  Widget _turn(){
    return Expanded(
      flex: 0,
        child:Padding(
          padding: EdgeInsets.all(15),
          child: Center(child: Text( _turnO ? "Y Turn" : "X Turn",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.w600 ),),
          ),
        ),
    );
  }
  void _tapped(int index){
    setState(() {
      if(!_turnO && _xolist[index] == ''){
        _xolist[index]='x';
        _filled+=1;
      }
      else if(_turnO && _xolist[index] == ''){
        _xolist[index]='o';
        _filled+=1;
      }

      _turnO=!_turnO;

      _wincheck();
    });
  }

  void _wincheck(){
    // check first row
    if (_xolist[0] == _xolist[1] &&
        _xolist[0] == _xolist[2] &&
        _xolist[0] != '') {
      _showAlertDialog('Winner', _xolist[0]);
      return;
    }

    // check second row
    if (_xolist[3] == _xolist[4] &&
        _xolist[3] == _xolist[5] &&
        _xolist[3] != '') {
      _showAlertDialog('Winner', _xolist[3]);
      return;
    }

    // check third row
    if (_xolist[6] == _xolist[7] &&
        _xolist[6] == _xolist[8] &&
        _xolist[6] != '') {
      _showAlertDialog('Winner', _xolist[6]);
      return;
    }

    // check first column
    if (_xolist[0] == _xolist[3] &&
        _xolist[0] == _xolist[6] &&
        _xolist[0] != '') {
      _showAlertDialog('Winner', _xolist[0]);
      return;
    }

    // check second column
    if (_xolist[1] == _xolist[4] &&
        _xolist[1] == _xolist[7] &&
        _xolist[1] != '') {
      _showAlertDialog('Winner', _xolist[1]);
      return;
    }

    // check third column
    if (_xolist[2] == _xolist[5] &&
        _xolist[2] == _xolist[8] &&
        _xolist[2] != '') {
      _showAlertDialog('Winner', _xolist[2]);
      return;
    }

    // check diagonal
    if (_xolist[0] == _xolist[4] &&
        _xolist[0] == _xolist[8] &&
        _xolist[0] != '') {
      _showAlertDialog('Winner', _xolist[0]);
      return;
    }

    // check diagonal
    if (_xolist[2] == _xolist[4] &&
        _xolist[2] == _xolist[6] &&
        _xolist[2] != '') {
      _showAlertDialog('Winner', _xolist[2]);
      return;
    }

    if (_filled == 9) {
      _showAlertDialog('Draw', '');
    }
  }


  void _showAlertDialog(String title, String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(winner == '' ? 'The match ended in a draw' : 'The winner is ${winner.toUpperCase()}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (winner == 'o') {
                  _scoreY+=1;
                } else if (winner == 'x') {
                  _scoreX+= 1;
                }
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void _clearBoard() {
    setState(() {
      for (int i=0;i<9;i++){
        _xolist[i]='';
      }
    });
    _filled=0;
  }
  void _clearStateBoard(){
    setState(() {
      for (int i=0;i<9;i++){
        _xolist[i]='';
      }
    });
    _scoreY=0;
    _scoreX=0;
    _filled=0;
  }

}
