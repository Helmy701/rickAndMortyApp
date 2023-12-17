import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/charactars.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactarDetailsScreen,
            arguments: character),
        child: GridTile(
          footer: Hero(
            tag: character,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColor.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColor.myGrey,
            child: character.image!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/loading.gif',
                    image: character.image!,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/placeholder.jpg'),
          ),
        ),
      ),
    );
  }
}
