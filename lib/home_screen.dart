import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var inputHide = false;
  var outSize = 34.0;

  onButton(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (value.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if(input.isNotEmpty){
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        userInput = input.replaceAll('/', '÷');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = '${expression.evaluate(EvaluationType.REAL, cm)}';
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
      }
      }
      input = output;
      inputHide = true;
      outSize =52;
    } else {
      input = input + value;
      inputHide = false;
      outSize = 34;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              inputHide ? '' : input,
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              output,
              style: TextStyle(
                fontSize: outSize,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(text: 'AC', txColor: Colors.redAccent, fontSize: 8),
              button(text: '<', txColor: Colors.redAccent, fontSize: 8),
              button(
                text: '%',
                txColor: Colors.redAccent,
              ),
              button(
                text: '÷',
                txColor: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                text: '7',
              ),
              button(
                text: '8',
              ),
              button(
                text: '9',
              ),
              button(
                text: 'x',
                txColor: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                text: '4',
              ),
              button(
                text: '5',
              ),
              button(
                text: '6',
              ),
              button(
                text: '-',
                txColor: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                text: '1',
              ),
              button(
                text: '2',
              ),
              button(
                text: '3',
              ),
              button(
                text: '+',
                txColor: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(text: '↻', txColor: Colors.redAccent),
              button(text: '0'),
              button(text: '.'),
              button(
                text: '=',
                txColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    txColor = Colors.black,
    bgColor = Colors.white,
    operatorColor = Colors.blueGrey,
    fontSize = 16,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(16),
            backgroundColor: bgColor,
          ),
          onPressed: () => onButton(text),
          child: Text(
            text,
            style: TextStyle(
              color: txColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
