import 'package:flutter/material.dart';
import 'package:vtech/util/const.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

List menuItems = [
  {
    "title": "Milestone",
  },
  {
    "title": "Albums",
  },
  {
    "title": "Account",
  },
    {
    "title": "Settings",
  },
    {
    "title": "Camera Sharing",
  },
    {
    "title": "Help & About",
  },
];


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              // title: const Text('Home Route'),
              backgroundColor: Colors.white,
              leading: IconButton (
                  icon: Icon(
                    Icons.menu,
                    color: Constants.secondary,
                  ), 
                 onPressed: () {
                  showMenu(context);
                 },
              ),
            ),
            body: DragHandleExample(),
          );
        },
        '/about': (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('About Route'),
            ),
          );
        }
      },
    );
  }

  showMenu(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: Colors.white,
          ),
          child: new ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              return new MenuItem(
                title: "${menuItems[index]["title"]}",
              );
            }
          ),
        );
      }
    );
  }
}

class MenuItem extends StatelessWidget {
  final String? title;

  MenuItem(
    { @required this.title }
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: new Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child:  Icon(
              Icons.bookmark_border,
              color: Constants.primary,
            ),
          ),
          Expanded(
            child: Container(
              // margin: EdgeInsets.only(right: 20.0),
              padding: EdgeInsets.symmetric(vertical: 13.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xfff0f0f0), width: 1.0 ))
              ),
              child: Text(
                title ?? '',
                style: TextStyle(color: Constants.primary)
              ),
            )
          )
        ],
      )
    );
  }
}


class DragHandleExample extends StatefulWidget {
  DragHandleExample({Key? key}) : super(key: key);

  @override
  _DragHandleExample createState() => _DragHandleExample();
}

class _DragHandleExample extends State<DragHandleExample> {
  late List<DragAndDropList> _contents;

  @override
  void initState() {
    super.initState();

    _contents = List.generate(1, (index) {
      return DragAndDropList(
        canDrag: false,
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    'Feature',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    'Sub $index.1',
                  ),
                ),
              ],
            ),
          ),
          DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    'Sub $index.2',
                  ),
                ),
              ],
            ),
          ),
          DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    'Sub $index.3',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Color.fromARGB(255, 243, 242, 248);

    return DragAndDropLists(
      children: _contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      listPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemDivider: Divider(
        thickness: 2,
        height: 2,
        color: backgroundColor,
      ),
      itemDecorationWhileDragging: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      listInnerDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      lastItemTargetHeight: 8,
      addLastItemTargetHeightToTop: true,
      lastListTargetSize: 40,
      itemDragHandle: DragHandle(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {}
}
  
 