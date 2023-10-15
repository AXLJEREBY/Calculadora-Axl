import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == 'AC') {
        _expression = '';
      } else if (buttonText == '=') {
        try {
          // Reemplaza el símbolo de raíz cuadrada con la función "sqrt" antes de evaluar la expresión.
          String modifiedExpression = _expression.replaceAll('√', 'sqrt');
          Parser p = Parser();
          Expression exp = p.parse(modifiedExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // Reemplaza "sqrt" con el símbolo de la raíz cuadrada en el resultado.
          _result =
              _expression + ' = ' + eval.toString().replaceAll('sqrt', '√');
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor,
      {bool isLong = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: buttonColor,
        ),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: isLong ? 16 : 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.black,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _result,
                        style: TextStyle(fontSize: 48, color: Colors.black),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('√', Colors.grey),
                      buildButton('x²', Colors.grey),
                      buildButton('sin', Colors.grey),
                      buildButton('cos', Colors.grey),
                      buildButton('tan', Colors.grey, isLong: true),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('7', Colors.grey),
                      buildButton('8', Colors.grey),
                      buildButton('9', Colors.grey),
                      buildButton('/', Colors.orange),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('4', Colors.grey),
                      buildButton('5', Colors.grey),
                      buildButton('6', Colors.grey),
                      buildButton('*', Colors.orange),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('1', Colors.grey),
                      buildButton('2', Colors.grey),
                      buildButton('3', Colors.grey),
                      buildButton('-', Colors.orange),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('0', Colors.grey),
                      buildButton('C', Colors.green),
                      buildButton('AC', Colors.red),
                      buildButton('=', Colors.blue),
                      buildButton('+', Colors.orange),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('(', Colors.grey),
                      buildButton(')', Colors.grey),
                      buildButton('ln', Colors.grey, isLong: true),
                      buildButton('%', Colors.grey),
                      buildButton('.', Colors.grey),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('^', Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
