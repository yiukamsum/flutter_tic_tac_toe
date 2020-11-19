import 'package:flutter/material.dart';
import "GameButton.dart";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Tic Tac Toe',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Tic Tac Toe'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    Board board = new Board(false);
    void initState() {
        setState(() {
            board = new Board(false);
        });
    }

    void _selectedButton(index){
        setState(() {
            String result = board.playerMove(index);
            debugPrint(result);
            if(result == "false"){
                
            } else {
                alert(context, result);
            }
        });
    }


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            // backgroundColor: Colors.grey,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            children: List.generate(9, (index) {
                                return Container(
                                    color: Colors.black,
                                    padding: EdgeInsets.all(8.0),
                                    child: FlatButton(
                                        child: Text(
                                            board.cell[index].text,
                                            style: TextStyle(fontSize: 50.0),
                                        ),
                                        color: Colors.white,
                                        textColor: Colors.black,
                                        onPressed: () {
                                            if(board.cell[index].enabled) _selectedButton(index);
                                        },
                                    ),
                                );
                            })
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: ButtonTheme(
                                minWidth: 200,
                                height: 80,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    child: Text('Restart Game'),
                                    onPressed: (){
                                        initState();
                                    }
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
    void alert(BuildContext context, text) {
        AlertDialog dialog = AlertDialog(
            title: Text("Alert"),
            content: Text(text),
            actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.of(context).pop(), //关闭对话框
                ),
            ],
        );
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => dialog,
        );
    }
}
