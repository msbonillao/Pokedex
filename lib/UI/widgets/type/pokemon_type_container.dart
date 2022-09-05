import 'package:flutter/material.dart';
import 'package:pokedex_flutter/UI/utils/type_colors.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:pokedex_flutter/utils/extensions/pokemon_type_extension.dart';
import 'package:pokedex_flutter/utils/extensions/string_extension.dart';

class PokemonTypeContainer extends StatelessWidget {
  const PokemonTypeContainer({
    Key? key,
    required this.type,
    this.size = 16,
  }) : super(key: key);
  final PokemonType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxHeight: size,
        minWidth: size * 3,
      ),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: pokemonTypeColors[type.id]!.withOpacity(0.6),
      ),
      child: Text(
        type.label.capitalize(),
        maxLines: 1,
        style: TextStyle(
          fontSize: size * (2/3),
          color: Color.lerp(
            type.color,
            Colors.white,
            0.8,
          ),
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
