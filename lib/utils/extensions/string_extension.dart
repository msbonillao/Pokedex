extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String formatPokemonDescription() {
    String copy = this;
    final replaces = {
      '\n': ' ',
      '\f': ' ',
      'POKéMON': 'Pokémon',
    };
    replaces.forEach((key, value) {
      copy = copy.replaceAll(key, value);
    });
    return copy;
  }
}
