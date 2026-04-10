class ChordTransposer {
  ChordTransposer._();

  static const List<String> notas = [
    'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  static const Map<String, String> _flatToSharp = {
    'Bb': 'A#',
    'Eb': 'D#',
    'Ab': 'G#',
    'Db': 'C#',
    'Gb': 'F#',
    'Cb': 'B',
    'Fb': 'E',
  };

  static final RegExp _chordPattern = RegExp(r'\[([A-G][#b]?[a-z0-9]*)\]');

  static String _normalizeNote(String note) {
    if (note.length >= 2 && note[1] == 'b') {
      final flat = note.substring(0, 2);
      if (_flatToSharp.containsKey(flat)) {
        return _flatToSharp[flat]!;
      }
    }
    return note;
  }

  static String _extractRoot(String chord) {
    if (chord.length >= 2 && (chord[1] == '#' || chord[1] == 'b')) {
      return chord.substring(0, 2);
    }
    return chord.substring(0, 1);
  }

  static String transposeChordPro(String input, String from, String to) {
    final fromNorm = _normalizeNote(from);
    final toNorm = _normalizeNote(to);

    final fromIndex = notas.indexOf(fromNorm);
    final toIndex = notas.indexOf(toNorm);

    if (fromIndex == -1 || toIndex == -1) return input;

    final delta = (toIndex - fromIndex + 12) % 12;
    if (delta == 0) return input;

    return input.replaceAllMapped(_chordPattern, (match) {
      final chord = match.group(1)!;
      final root = _extractRoot(chord);
      final suffix = chord.substring(root.length);
      final normRoot = _normalizeNote(root);
      final rootIndex = notas.indexOf(normRoot);
      if (rootIndex == -1) return match.group(0)!;
      final newRoot = notas[(rootIndex + delta) % 12];
      return '[$newRoot$suffix]';
    });
  }

  static String removeChordBrackets(String input) {
    return input.replaceAllMapped(_chordPattern, (match) {
      return match.group(1)!;
    });
  }
}
