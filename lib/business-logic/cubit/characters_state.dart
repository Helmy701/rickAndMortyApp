part of 'characters_cubit.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  //what will u appear to me
  final List<Character> characters;

  CharactersLoaded(this.characters);
}
