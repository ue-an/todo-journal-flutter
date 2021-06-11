import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:journal_todo/models/entry_model.dart';
import 'package:journal_todo/providers/journal_provider.dart';
import 'package:journal_todo/screens/journal_entry.dart';
import 'package:journal_todo/utils/routes.dart';
import 'package:provider/provider.dart';

class JournalScreen extends StatelessWidget {
  ScrollController _hideButtonCtrl = new ScrollController();
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<JEntryProvider>(context);

    _hideButtonCtrl.addListener(() {
      if (_hideButtonCtrl.position.atEdge) {
        if (_hideButtonCtrl.position.pixels > 0) if (_isVisible) {
          _isVisible = false;
        }
      } else {
        if (!_isVisible) {
          _isVisible = true;
        }
      }
    });

    return Scaffold(
      body: //Text('Journal Home'),
          Column(
        children: [
          TopBarJhome(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(),
              child: StreamBuilder<List<Entry>>(
                stream: entryProvider.entries,
                builder: (context, snapshot) {
                  return ListView.builder(
                    controller: _hideButtonCtrl,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            formatDate(
                                DateTime.parse(snapshot.data[index].date),
                                [MM, ' ', d, ' ,', yyyy]),
                          ),
                          trailing: Icon(
                            Icons.edit,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => JEntryScreen(
                                  entry: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // body: StreamBuilder<List<Entry>>(
      //   stream: entryProvider.entries,
      //   builder: (context, snapshot) {
      //     return ListView.builder(
      //       itemCount: snapshot.data.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           title: Text(
      //             formatDate(DateTime.parse(snapshot.data[index].date),
      //                 [MM, '', d, ',', yyyy]),
      //           ),
      //           trailing: Icon(
      //             Icons.edit,
      //             color: Theme.of(context).accentColor,
      //           ),
      //           onTap: () {},
      //         );
      //       },
      //     );
      //   },
      // ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.jentry);
          },
        ),
      ),
    );
  }
}

class TopBarJhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 3),
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Journal List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  // bottomLeft
                  offset: Offset(-1, -1),
                ),
                Shadow(
                  // bottomRight
                  offset: Offset(1, -1),
                ),
                Shadow(
                  // topRight
                  offset: Offset(1, 1),
                ),
                Shadow(
                  // topLeft
                  offset: Offset(-1, 1),
                ),
              ],
            ),
          ),
          // Text(
          //   '${TEntryProvider().showTotalTasks()} Tasks',
          //   //'Tasks',
          //   style: TextStyle(
          //     color: Theme.of(context).primaryColor,
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
