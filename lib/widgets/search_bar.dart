import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app_clone/state/search_state.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
//     Start listening to changes.
     _textEditingController.addListener(
      _sendSearch
     );
  }

  _sendSearch() {
    if(_textEditingController.value.selection.baseOffset != 0) {
      context.read<SearchState>().search(_textEditingController.text);
    } else {
      context.read<SearchState>().clear();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(color: Colors.blueGrey),
          color: Colors.transparent
        ),
        child: TextField(
          controller: _textEditingController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () => _textEditingController.clear(),
              icon: Icon(Icons.clear),
            ),
            border: InputBorder.none,
            hintText: 'Search for symbols and companies...',
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
