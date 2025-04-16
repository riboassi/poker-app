final Map<String, Map<int, double>> winProbabilities = {
  'AA': {2: 85.0, 3: 81.0, 4: 78.0, 5: 75.0, 6: 72.0, 7: 69.0, 8: 66.0, 9: 63.0},
  'AKs': {2: 66.0, 3: 60.0, 4: 55.0, 5: 51.0, 6: 48.0, 7: 45.0, 8: 42.0, 9: 39.0},
  'AKo': {2: 65.0, 3: 59.0, 4: 54.0, 5: 50.0, 6: 47.0, 7: 44.0, 8: 41.0, 9: 38.0},
  'TT': {2: 78.0, 3: 70.0, 4: 63.0, 5: 57.0, 6: 52.0, 7: 47.0, 8: 43.0, 9: 39.0},
  'QJo': {2: 53.0, 3: 48.0, 4: 44.0, 5: 41.0, 6: 38.0, 7: 35.0, 8: 32.0, 9: 30.0},
};

String convertToHandNotation(String card1Value, String card2Value, String suit1, String suit2) {
  String normalize(String value) {
    switch (value) {
      case '1': return 'A';
      case '10': return 'T';
      case '11': return 'J';
      case '12': return 'Q';
      case '13': return 'K';
      default: return value;
    }
  }

  String v1 = normalize(card1Value);
  String v2 = normalize(card2Value);

  List<String> sorted = [v1, v2]..sort((a, b) => 'AKQJT98765432'.indexOf(a).compareTo('AKQJT98765432'.indexOf(b)));
  String base = sorted[0] + sorted[1];

  if (v1 == v2) return v1 + v2;
  String suited = suit1 == suit2 ? 's' : 'o';
  return base + suited;
}

double? getWinProbability(String handCode, int opponents) {
  return winProbabilities[handCode]?[opponents];
}
