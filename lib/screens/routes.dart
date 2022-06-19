import 'package:flutter/material.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoutesPageState();
}

class RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: ChooseList(["123", "456", "789"]),
          ),
          Expanded(
            child: ListView(
              children: [
                RouteCard("Route 1", "Very nice places", Icons.directions_walk),
                RouteCard("Route 2", "Very nice places", Icons.directions_walk),
                RouteCard("Route 3", "Very nice places", Icons.directions_walk),
                RouteCard("Route 4", "Very nice places", Icons.directions_walk),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RouteCard extends StatelessWidget {
  const RouteCard(this._title, this._description, this._icon, {Key? key})
      : super(key: key);

  final String _title;
  final String _description;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => print("next screen"),
          child: ListTile(
            leading: Icon(_icon),
            title: Text(_title),
            subtitle: Text(_description),
          ),
        ),
      ),
    );
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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => print(_results[index]),
                      child: ChooseListEntry(
                        _results[index],
                      ),
                    ),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const Divider(
          height: 15,
          thickness: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
