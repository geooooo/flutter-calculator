import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


typedef OnPressed = void Function();


void main() => runApp(App());


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: 'Калькулятор',
      home: Main(),
    );

}


class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CalculatorInput(),
            Expanded(
              child: CalculatorButtons(),
            ),
          ],
        ),
      ),
    );

}


class CalculatorInput extends  StatelessWidget{

  final _border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 3,
      style:BorderStyle.solid,
    ),
  );

  final _textStyle = TextStyle(
    color: Colors.lightGreenAccent,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 30,
  );

  @override
  Widget build(BuildContext context) =>
    Container(
      padding:EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.lightGreen,
        style: _textStyle,
        decoration: InputDecoration(
          hintText: "1+2",
          hintStyle: _textStyle.copyWith(
            color: Colors.white,
          ),
          enabledBorder: _border,
          focusedBorder: _border.copyWith(
            borderSide: _border.borderSide.copyWith(
              color: Colors.lightGreenAccent,
            ),
          ),
        ),
      ),
    );

}


class CalculatorButtons extends StatelessWidget {

  final row1 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CalculatorButton(
        title: '1',
        onPressed: () => _onButtonPressed('1')
      ),
      CalculatorButton(
        title: '2',
        onPressed: () => _onButtonPressed('2')
      ),
      CalculatorButton(
        title: '3',
        onPressed: () => _onButtonPressed('3')
      ),
    ],
  );

  final row2 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CalculatorButton(
        title: '4',
        onPressed: () => _onButtonPressed('4')
      ),
      CalculatorButton(
        title: '5',
        onPressed: () => _onButtonPressed('5')
      ),
      CalculatorButton(
        title: '6',
        onPressed: () => _onButtonPressed('6')
      ),
    ],
  );

  final row3 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CalculatorButton(
        title: '7',
        onPressed: () => _onButtonPressed('7')
      ),

      CalculatorButton(
        title: '8',
        onPressed: () => _onButtonPressed('8')
      ),
      CalculatorButton(
        title: '9',
        onPressed: () => _onButtonPressed('9')
      ),
    ],
  );

  final row4 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CalculatorButton(
        title: '0',
        onPressed: () => _onButtonPressed('0')
      ),
     CalculatorButton(
        title: '+',
        onPressed: () => _onButtonPressed('+')
      ),
      CalculatorButton(
        title: '-',
        onPressed: () => _onButtonPressed('-')
      ),
    ],
  );

  final row5 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CalculatorButton(
        title: '*',
        onPressed: () => _onButtonPressed('*')
      ),
      CalculatorButton(
        title: '/',
        onPressed: () => _onButtonPressed('/')
      ),
      CalculatorButton(
        title: '=',
        onPressed: () => _onButtonPressed('=')
      ),
    ],
  );

  @override
  Widget build(BuildContext context) =>
    Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          row1,
          row2,
          row3,
          row4,
          row5,
        ],
      ),
    );

  static void _onButtonPressed(String title) {
    print(title);
  }

}


class CalculatorButton extends StatelessWidget {

  final String title;
  final OnPressed onPressed;

  CalculatorButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) =>
    FlatButton(
      onPressed: onPressed,
      color: Colors.transparent,
      padding: EdgeInsets.all(20),
      splashColor: Colors.lightGreenAccent,
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3,
          style:BorderStyle.solid,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

}
