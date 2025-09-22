class FuzzySearch {
  static List<T> search<T>(
    List<T> items,
    String query,
    String Function(T) getSearchableText,
  ) {
    if (query.isEmpty) return items;

    final normalizedQuery = _normalize(query);
    final results = <_SearchResult<T>>[];

    for (final item in items) {
      final searchableText = _normalize(getSearchableText(item));
      final score = _calculateScore(searchableText, normalizedQuery);

      if (score > 0) {
        results.add(_SearchResult(item: item, score: score));
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results.map((result) => result.item).toList();
  }

  static String _normalize(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
  }

  static double _calculateScore(String text, String query) {
    if (text.isEmpty || query.isEmpty) return 0.0;

    if (text == query) return 1.0;

    if (text.contains(query)) {
      final index = text.indexOf(query);
      final lengthRatio = query.length / text.length;
      final positionBonus = index == 0
          ? 0.3
          : (1.0 - index / text.length) * 0.2;
      return 0.5 + lengthRatio * 0.3 + positionBonus;
    }

    final words = text.split(' ');
    final queryWords = query.split(' ');

    double totalScore = 0.0;
    int matchedWords = 0;

    for (final queryWord in queryWords) {
      for (final word in words) {
        if (word.contains(queryWord)) {
          final wordScore = queryWord.length / word.length;
          totalScore += wordScore;
          matchedWords++;
          break;
        }
      }
    }

    if (matchedWords == 0) return 0.0;

    final wordMatchRatio = matchedWords / queryWords.length;
    final averageWordScore = totalScore / matchedWords;

    return wordMatchRatio * 0.4 + averageWordScore * 0.3;
  }
}

class _SearchResult<T> {
  final T item;
  final double score;

  _SearchResult({required this.item, required this.score});
}
