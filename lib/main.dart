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
      home: const MyHomePage(title: 'TICTACTOE'),
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
  int filled=0;
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
              icon: Icon(Icons.refresh))
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
      flex: 3,
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
        filled+=1;
      }
      else if(_turnO && _xolist[index] == ''){
        _xolist[index]='o';
        filled+=1;
      }

      _turnO=!_turnO;
      if(filled==3 || filled==5 || filled==7 ||  filled== 8 || filled ==9){
        _wincheck();
      }


    });
  }

  void _wincheck(){
    //row 1
    if(_xolist[0]==_xolist[1] &&
    _xolist[0]==_xolist[2] &&_xolist[0]!=''){
      _showAlertDialog(context,"Winner", _xolist[0]);
      return;
    }
    //row2
    if (_xolist[3]==_xolist[4] &&
        _xolist[3]==_xolist[5] &&_xolist[3]!=''){
      _showAlertDialog(context,"Winner", _xolist[3]);
      return;
    }
    //row3
    if (_xolist[6]==_xolist[7] &&
        _xolist[6]==_xolist[8] &&_xolist[7]!=''){
      _showAlertDialog(context,"Winner", _xolist[7]);
      return;
    }
    //col1
    if (_xolist[0]==_xolist[3] &&
        _xolist[0]==_xolist[6] &&_xolist[0]!=''){
      _showAlertDialog(context,"Winner", _xolist[0]);
      return;
    }
    //col2
    if (_xolist[1]==_xolist[4] &&
        _xolist[1]==_xolist[7] &&_xolist[1]!=''){
      _showAlertDialog(context,"Winner", _xolist[1]);
      return;
    }
    //col3
    if(_xolist[2]==_xolist[5] &&
        _xolist[2]==_xolist[8] &&_xolist[0]!=''){
      _showAlertDialog(context,"Winner", _xolist[2]);
      return;
    }
    if(_xolist[0]==_xolist[4] && _xolist[0]==_xolist[8] &&_xolist[0]==''){
      _showAlertDialog(context,"Winner", _xolist[0]);
      return;
    }
    if(_xolist[2]==_xolist[4] && _xolist[2]==_xolist[6] &&_xolist[2]==''){
      _showAlertDialog(context,"Winner", _xolist[0]);
      return;
    }
    if(filled==9){
      _showAlertDialog(context, "Draw",'');
    }

  }

  /*void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == '' ? 'The match ended in a draw' : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          if (winner == 'o') {
             _scoreY+=1;
          } else if (winner == 'x') {
            _scoreX+= 1;
          }
          _clearBoard();
          Navigator.of(context).pop();
        }
    );
  }*/
  void _showAlertDialog(BuildContext context, String title, String winner) {
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
    filled=0;
  }

}
