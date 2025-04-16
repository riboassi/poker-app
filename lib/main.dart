import 'package:flutter/material.dart';
import 'poker_logic.dart';

void main() => runApp(const PokerApp());

class PokerApp extends StatelessWidget {
  const PokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker APP',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const PokerHomePage(),
    );
  }
}

class PokerHomePage extends StatefulWidget {
  const PokerHomePage({super.key});

  @override
  State<PokerHomePage> createState() => _PokerHomePageState();
}

class _PokerHomePageState extends State<PokerHomePage> {
  String? card1Value = 'A';
  String? card2Value = 'K';
  String? card1Suit = '♠';
  String? card2Suit = '♠';
  int opponents = 5;
  double? winProbability;
  String? errorMessage;

  final List<String> cardValues = ['A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2'];
  final List<String> suits = ['♠', '♥', '♣', '♦'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poker APP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: cardPicker('Carta 1', card1Value, (value) => setState(() => card1Value = value))),
                const SizedBox(width: 10),
                Expanded(child: suitPicker(card1Suit, (value) => setState(() => card1Suit = value))),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: cardPicker('Carta 2', card2Value, (value) => setState(() => card2Value = value))),
                const SizedBox(width: 10),
                Expanded(child: suitPicker(card2Suit, (value) => setState(() => card2Suit = value))),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Oponentes:'),
                const SizedBox(width: 20),
                DropdownButton<int>(
                  value: opponents,
                  items: List.generate(8, (index) => index + 2)
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (val) => setState(() => opponents = val!),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final notation = convertToHandNotation(card1Value!, card2Value!, card1Suit!, card2Suit!);
                final probability = getWinProbability(notation, opponents);
                setState(() {
                  winProbability = probability;
                  errorMessage = probability == null ? 'Mão não reconhecida na tabela.' : null;
                });
              },
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            if (winProbability != null)
              Text(
                '→ Probabilidade estimada: ${winProbability!.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 18),
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget cardPicker(String label, String? currentValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          items: cardValues.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget suitPicker(String? currentSuit, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: currentSuit,
      isExpanded: true,
      items: suits.map((suit) {
        Color color = (suit == '♥' || suit == '♦') ? Colors.red : Colors.black;
        return DropdownMenuItem(
          value: suit,
          child: Text(suit, style: TextStyle(color: color, fontSize: 18)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
