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
    if(_textEditingController.value.selection.baseOffset != 0 && _textEditingController.text != '') {
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
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white30
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: _textEditingController,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(Icons.search, color: Colors.white70),
          suffixIcon: IconButton(
            onPressed: () => _textEditingController.clear(),
            icon: Icon(Icons.clear, color: Colors.white70,),
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
