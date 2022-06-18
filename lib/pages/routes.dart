import 'package:flutter/material.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return const ChooseList(["asd", "фыв", "qwe", "йцу"]);
  }
}

class ChooseList extends StatefulWidget {
  final List<String> list;

  const ChooseList(this.list, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChooseListState();
}

class ChooseListState extends State<ChooseList> {
  List<String> _results = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _results = widget.list;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.list;
    } else {
      results = widget.list
          .where((String entry) =>
              entry.toLowerCase().startsWith(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
              labelText: 'Choose your city',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _results.isNotEmpty
                ? ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) => ChooseListEntry(_results[index]),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }
}

class ChooseListEntry extends StatelessWidget {
  final String value;

  const ChooseListEntry(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Text(
            value,
          ),
        ),
        const Divider(
          height: 10,
          thickness: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
