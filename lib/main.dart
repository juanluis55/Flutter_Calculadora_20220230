
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculadora',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "On") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Calculadora'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize)),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
            buildButtonRow(['On', '9', '*', '/']),
            const SizedBox(height: 20),  // Espacio vertical
            buildButtonRow(['6', '7', '8', '-']),
            const SizedBox(height: 20),  // Espacio vertical
            buildButtonRow(['3', '4', '5', '+']),
            const SizedBox(height: 20),  // Espacio vertical
            buildButtonRow(['2', '1', '0', '=']),
            ],
          ),
        ],
      ),
    );
  }

  Row buildButtonRow(List<String> buttonValues) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: buttonValues.expand((buttonText) => [
      SizedBox(
        width: 90.0, 
        height: 60.0, 
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText),
        ),
      )  
    ]).toList()// Remover el último espacio sobrante
  );
}
}
