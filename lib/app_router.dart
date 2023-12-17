import 'package:app_using_bloc/data/models/charactars.dart';
import 'package:app_using_bloc/presentation/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business-logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/repository/charactars_repository.dart';
import 'data/web-services/charactars_web_services.dart';
import 'presentation/screens/characters_screens.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case charactarDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharactarDetailsScreen(character: character));
    }
    return null;
  }
}
