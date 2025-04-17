
const cards = ['A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2'];
const suits = ['♠', '♥', '♦', '♣'];

String calculateOdds(String c1, String s1, String c2, String s2, int opponents) {
  if (c1 == c2 && s1 == s2) return 'Cartas iguais e mesmo naipe não são válidas.';
  String handKey = _formatHand(c1, s1, c2, s2);
  return _probTable.containsKey('$handKey-$opponents') ?
      'Probabilidade de vitória: ${_probTable['$handKey-$opponents']}%' :
      'Ainda não temos a probabilidade desta combinação.';
}

String _formatHand(String c1, String s1, String c2, String s2) {
  List<String> values = [c1, c2]..sort((a, b) => cards.indexOf(a).compareTo(cards.indexOf(b)));
  bool suited = s1 == s2;
  if (c1 == c2) return '${values[0]}${values[1]}';
  return '${values[1]}${values[0]}${suited ? 's' : 'o'}';
}

const _probTable = {
  'AKs-5': 22.0,
  'AQo-5': 19.5,
  'QQ-5': 24.0,
  '72o-5': 8.0,
  'AA-5': 31.0,
};
