import 'package:app_using_bloc/constants/my_colors.dart';
import 'package:app_using_bloc/data/models/charactars.dart';
import 'package:flutter/material.dart';

class CharactarDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactarDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(color: MyColor.myWhite),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character,
          child: Image.network(
            character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColor.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColor.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('species : ', character.species!),
                      buildDivider(300),
                      characterInfo('gender : ', character.gender!),
                      buildDivider(305),
                      characterInfo('Number of episode : ',
                          character.episode!.length.toString()),
                      buildDivider(210),
                      characterInfo(
                          'episode : ', character.episode!.join(' / ')),
                      buildDivider(300),
                      characterInfo('status : ', character.status!),
                      buildDivider(315),
                      character.type!.isEmpty
                          ? Container()
                          : characterInfo('type : ', character.type!),
                      character.type!.isEmpty ? Container() : buildDivider(328),
                      characterInfo('Number of episode : ',
                          character.episode!.length.toString()),
                      buildDivider(210),
                      characterInfo(
                        'Origin : ',
                        character.origin!.name!,
                      ),
                      buildDivider(315),
                      characterInfo(
                        'Location : ',
                        character.location!.name!,
                      ),
                      buildDivider(315),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
