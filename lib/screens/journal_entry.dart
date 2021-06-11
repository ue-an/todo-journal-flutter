import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:journal_todo/models/entry_model.dart';
import 'package:journal_todo/providers/journal_provider.dart';
import 'package:journal_todo/utils/routes.dart';
import 'package:provider/provider.dart';

class JEntryScreen extends StatefulWidget {
  final Entry entry;
  JEntryScreen({this.entry});

  @override
  _JEntryScreenState createState() => _JEntryScreenState();
}

class _JEntryScreenState extends State<JEntryScreen> {
  final jentryCtrl = TextEditingController();
  @override
  void dispose() {
    jentryCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final journalProvider = Provider.of<JEntryProvider>(context, listen: false);
    if (widget.entry != null) {
      //edit
      jentryCtrl.text = widget.entry.entry;
      journalProvider.loadAll(widget.entry);
    } else {
      //add
      journalProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JEntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        //title: Text('Journal Entry'),
        title: Text(formatDate(journalProvider.date, [MM, ' ', d, ', ', yyyy])),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              //pickdate
              _pickDate(context, journalProvider).then((value) {
                if (value != null) {
                  journalProvider.changeDate = value;
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add to Journal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.cyan,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.cyan,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                labelText: 'Daily Journal Entry',
                labelStyle: TextStyle(color: Colors.cyan),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) => journalProvider.changeEntry = value,
              controller: jentryCtrl,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(
                    'Save',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    journalProvider.saveEntry();
                    Navigator.of(context).pop();
                  },
                ),
                (widget.entry != null)
                    ? ElevatedButton(
                        child: Text(
                          'Delete',
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                elevation: 15,
                                child: Container(
                                  height: 175,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 36,
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Text('Remove this from your journal?'),
                                        SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                Navigator.of(context).pop();
                                                jentryCtrl.text = '';
                                                await journalProvider
                                                    .removeEntry(
                                                        widget.entry.entryID);
                                                Fluttertoast.showToast(
                                                  msg: 'Deleted!',
                                                  gravity: ToastGravity.BOTTOM,
                                                );
                                              },
                                              child: Text('Yes'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              child: Text('No'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : ElevatedButton(
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime> _pickDate(
      BuildContext context, JEntryProvider jEntryProvider) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: jEntryProvider.date,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
    );
    if (picked != null) return picked;
  }
}
