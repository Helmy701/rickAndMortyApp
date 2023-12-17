import '../models/charactars.dart';
import '../web-services/charactars_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((element) => Character.fromJson(element))
        .toList(); // characters.fromJsaon that's in model
  }
}
