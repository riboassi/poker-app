
import 'package:flutter/material.dart';
import 'poker_logic.dart';

void main() => runApp(PokerApp());

class PokerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PokerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PokerHomePage extends StatefulWidget {
  @override
  _PokerHomePageState createState() => _PokerHomePageState();
}

class _PokerHomePageState extends State<PokerHomePage> {
  String selectedCard1 = 'A';
  String selectedCard2 = 'K';
  String selectedSuit1 = '♠';
  String selectedSuit2 = '♣';
  int opponents = 5;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Poker APP')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCard1,
              items: cards.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (v) => setState(() => selectedCard1 = v!),
            ),
            DropdownButton<String>(
              value: selectedSuit1,
              items: suits.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (v) => setState(() => selectedSuit1 = v!),
            ),
            DropdownButton<String>(
              value: selectedCard2,
              items: cards.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (v) => setState(() => selectedCard2 = v!),
            ),
            DropdownButton<String>(
              value: selectedSuit2,
              items: suits.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (v) => setState(() => selectedSuit2 = v!),
            ),
            DropdownButton<int>(
              value: opponents,
              items: List.generate(9, (i) => DropdownMenuItem(child: Text('${i + 1}'), value: i + 1)),
              onChanged: (v) => setState(() => opponents = v!),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = calculateOdds(selectedCard1, selectedSuit1, selectedCard2, selectedSuit2, opponents);
                });
              },
              child: Text("Calcular"),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(color: Colors.red, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
