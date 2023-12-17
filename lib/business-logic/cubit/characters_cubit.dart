import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/charactars.dart';
import '../../data/repository/charactars_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> mycharacters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<Character>? getAllCharacters() {
    charactersRepository.getAllCharacters().then((character) {
      emit(CharactersLoaded(character));
      mycharacters = character;
    });
    return mycharacters;
  }
}
