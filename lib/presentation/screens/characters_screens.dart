import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../business-logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/charactars.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters;
  List<Character>? searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildCubitWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGrey,
        child: Column(
          children: [buildCharacterGrid()],
        ),
      ),
    );
  }

  Widget buildCharacterGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters?.length
          : searchedForCharacters?.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters![index]
              : searchedForCharacters![index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColor.myGrey),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColor.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColor.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColor.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacters) {
        print(_searchTextController.text);
        addSearchedForItemsToSeacheredList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemsToSeacheredList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        ?.where(
          (character) =>
              character.name!.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            // if(_searchTextController != null)
            // {
            //   _clearSearch();
            // }
            // else
            // {
            //   Navigator.pop(context);
            //   setState(() {
            //     _isSearching = false;
            //   });
            // }
            _clearSearch();
            Navigator.pop(context);
            // setState(() {
            //   _isSearching = false;
            // });
          },
          icon: const Icon(
            Icons.clear,
            color: MyColor.myGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearching,
          icon: const Icon(
            Icons.search,
            color: MyColor.myGrey,
          ),
        ),
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  Widget noInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            const Text(
              'can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColor.myGrey,
              ),
            ),
            Image.asset('assets/images/undraw_Warning_re_eoyh.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton(
                color: MyColor.myGrey,
              )
            : const SizedBox(),
        backgroundColor: MyColor.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarAction(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildCubitWidget();
          } else {
            return noInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
