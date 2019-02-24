import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:math_expressions/math_expressions.dart';


abstract class Action {}

class CalculateExpressionAction extends Action {}

class ClearAction extends Action {}

class InputExpressionAction extends Action {
  final value;
  InputExpressionAction(this.value);
}


typedef OnPressed = void Function();
typedef OnClear = void Function();
typedef OnButtonPressed = void Function(String);
typedef OnCalculate = void Function();


class CalculatorState {

  String expression = '';

  CalculatorState.initial();

  String toString() => 'expression = $expression';

}


class ViewModel {
  final String expression;
  final OnButtonPressed onButtonPressed;
  final OnCalculate onCalculate;
  final OnClear onClear;
  ViewModel({
    this.expression,
    this.onClear,
    this.onButtonPressed,
    this.onCalculate
  });
}


CalculatorState reducer(CalculatorState state, dynamic action) {
  print('Action: ${action.runtimeType}');
  if (action is CalculateExpressionAction) {
    try {
      state.expression = (Parser().parse(state.expression)
                                 .evaluate(EvaluationType.REAL, ContextModel()) as num)
                                 .toStringAsFixed(0);
    } catch(_) {
      print('error: invalid expression !');
    }
  } else if (action is InputExpressionAction) {
    print('value: ${action.value}');
    state.expression += action.value;
  } else if (action is ClearAction) {
    state.expression = '';
  }
  print('state: $state');
  return state;
}


void main() {
  final store = Store<CalculatorState>(reducer, initialState: CalculatorState.initial());
  runApp(App(store: store));
}


class App extends StatelessWidget {

  final Store<CalculatorState> store;

  App({this.store});

  @override
  Widget build(BuildContext context) => StoreProvider(
    store: store,
    child: MaterialApp(
      title: 'Калькулятор',
      home: Main(),
    ),
  );

}


class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
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


class CalculatorInput extends StatefulWidget {

  @override
  _CalculatorInputState createState() => _CalculatorInputState();

}


class _CalculatorInputState extends State<CalculatorInput> {

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
      child: StoreConnector<CalculatorState, ViewModel>(
        converter: (Store<CalculatorState> store) => ViewModel(
          expression: store.state.expression,
          onClear: () => store.dispatch(ClearAction()),
        ),
        builder: (BuildContext context, ViewModel viewModel) => GestureDetector(
          onDoubleTap: viewModel.onClear,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
                style:BorderStyle.solid,
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Text(
              viewModel.expression,
              style: _textStyle,
            ),
          ),
        ),
      ),
    );

}


class CalculatorButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
    Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: StoreConnector<CalculatorState, ViewModel>(
        converter: (Store<CalculatorState> store) => ViewModel(
          onButtonPressed: (String value) => store.dispatch(InputExpressionAction(value)),
          onCalculate: () => store.dispatch(CalculateExpressionAction()),
        ),
        builder: (BuildContext buildContext, ViewModel viewModel) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CalculatorButton(
                  title: '1',
                  onPressed: () => viewModel.onButtonPressed('1')
                ),
                CalculatorButton(
                  title: '2',
                  onPressed: () => viewModel.onButtonPressed('2')
                ),
                CalculatorButton(
                  title: '3',
                  onPressed: () => viewModel.onButtonPressed('3')
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CalculatorButton(
                  title: '4',
                  onPressed: () => viewModel.onButtonPressed('4')
                ),
                CalculatorButton(
                  title: '5',
                  onPressed: () => viewModel.onButtonPressed('5')
                ),
                CalculatorButton(
                  title: '6',
                  onPressed: () => viewModel.onButtonPressed('6')
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CalculatorButton(
                  title: '7',
                  onPressed: () => viewModel.onButtonPressed('7')
                ),
                CalculatorButton(
                  title: '8',
                  onPressed: () => viewModel.onButtonPressed('8')
                ),
                CalculatorButton(
                  title: '9',
                  onPressed: () => viewModel.onButtonPressed('9')
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CalculatorButton(
                  title: '0',
                  onPressed: () => viewModel.onButtonPressed('0')
                ),
                CalculatorButton(
                  title: '+',
                  onPressed: () => viewModel.onButtonPressed('+')
                ),
                CalculatorButton(
                  title: '-',
                  onPressed: () => viewModel.onButtonPressed('-')
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CalculatorButton(
                  title: '*',
                  onPressed: () => viewModel.onButtonPressed('*')
                ),
                CalculatorButton(
                  title: '/',
                  onPressed: () => viewModel.onButtonPressed('/')
                ),
                CalculatorButton(
                  title: '=',
                  onPressed: () => viewModel.onCalculate()
                ),
              ],
            ),
          ],
        ),
      ),
    );

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
