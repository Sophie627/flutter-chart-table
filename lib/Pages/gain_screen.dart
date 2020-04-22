import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:youtimizer/Modal/notificationItem.dart';
import 'package:youtimizer/Pages/Login.dart';
import 'package:youtimizer/Modal/Shared.dart';
import 'package:youtimizer/Widgets/Loader.dart';
import 'package:youtimizer/Modal/Authentication.dart';
// import 'package:youtimizer/Widgets/Theme.dart';
import 'package:youtimizer/Widgets/AppDrawer.dart';
import 'package:youtimizer/Widgets/ScreenTitle.dart';
import 'package:youtimizer/Widgets/ScreenSelect.dart';
import 'package:youtimizer/Modal/HomeData.dart';
// import 'package:youtimizer/Modal/CustomError.dart';
// import 'package:fcharts/fcharts.dart';
import 'package:youtimizer/Widgets/CustomGraph.dart';
import 'package:youtimizer/Pages/PdfView.dart';
import 'package:youtimizer/Pages/BattingPage.dart';
import 'package:youtimizer/Pages/Address.dart';
import 'package:intl/intl.dart';

final bgColor = const Color(0xff99cc33);
final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['notification'] ?? message;
  final String title = data['title'];
  final String body = data['body'];
  final Item item = _items.putIfAbsent(title, () => Item(title: title, body: body))
    ..status = data['status'];
  return item;
}

class GainScreen extends StatefulWidget {
  int uid;

  GainScreen({this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GainScreenState();
  }
}

class GainScreenState extends State<GainScreen> {
  Shared shared = Shared();
  Authentication authentication = Authentication();
  String address;
  bool inProgress = true;
  HomeData homeData = HomeData();
  GraphData graphData = GraphData(y: [], x: []);
  List<String> year = [];
  List<String> gain = [];
  List<String> x = [];
  List<double> y = [];
  List<String> amount = [];
  List<bool> btnColor = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      title: Text(item.title),
      content: Text(item.body),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        // FlatButton(
        //   child: const Text('SHOW'),
        //   onPressed: () {
        //     Navigator.pop(context, true);
        //   },
        // ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("UID ${widget.uid}");

    fetchData();
    fetchYear(widget.uid);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  fetchYear(uid) async {
    authentication.fetchGainYearData(uid).then((res) {
      print("Year");
      print(res);

      btnColor.add(true);
      for (var i = 0; i < res['year'].length; i++) {
        gain.add(res['gain'][i]);
        year.add(res['year'][i]);
        btnColor.add(false);
      }
      setState(() {
        gain = gain;
        year = year;
        btnColor = btnColor;
        // inProgress = false;
      });
      print("Year ${year}");
    });
  }

  fetchData() async {
    setState(() => inProgress = true);
    DateTime now = new DateTime.now();
    var moonLanding = now.year;

    authentication.fetchYearGainTableData(widget.uid, moonLanding).then((res) {
      print("HOME");
      print(res);
      if (res == null) {
        setState(() {
          homeData = null;
        });
      }else{
        var data = HomeData.fromJSON(res);

        setState(() {
          homeData = data;
        });
      }

      setState(() => inProgress = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Container(
          height: 35.0,
          child: Image.asset("images/logo.png"),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.black,
      endDrawer: AppDrawer(uid: widget.uid),
      body: inProgress
          ? Loader()
          : homeData != null
              ? GainScreenView(
                  homeData: homeData,
                  x: x,
                  y: y,
                  address: address,
                  year: year,
                  gain: gain,
                  uid: widget.uid,
                  amount: amount,
                  parent: this,
                  btnColor: btnColor,
                )
              : Container(
                  child: Center(
                    child: Text("No data found",style: TextStyle(color: Colors.white),),
                  )
                ),
    );
  }
}

class GainScreenView extends StatelessWidget {
  HomeData homeData;
  String address;
  List<String> x = [];
  List<double> y = [];
  List<String> amount = [];
  List<String> year = [];
  List<String> gain = [];
  List<bool> btnColor = [];
  int uid;
  Authentication authentication = Authentication();
  GainScreenState parent;

  GainScreenView({this.homeData, this.x, this.y, this.address, this.gain, this.year, this.amount, this.uid, this.parent, this.btnColor});

  List<TableRow> widgets = [];

  @override
  Widget build(BuildContext context) {

    double flexVal = 1.5;
    if (MediaQuery.of(context).orientation == Orientation.portrait &&
        MediaQuery.of(context).size.width <= 320) {
      flexVal = 1.0;
    }

    widgets = [];
    widgets.add(
      TableRow(
        children: [
          rowDesign('Date', true),
          rowDesign('Post', true),
          rowDesign('Amount', true),
          rowDesign('Account', true)
        ],
      ),
    );

    fetchData(year) async {
      this.parent.setState(() => this.parent.inProgress = true);

      authentication.fetchYearGainTableData(uid, year).then((res) {
        print("HOME");
        print(res);
        if (res == null) {
          this.parent.setState(() {
            this.parent.homeData = null;
          });
        }else{
          var data = HomeData.fromJSON(res);

          this.parent.setState(() {
            this.parent.homeData = data;
          });
        }

        this.parent.setState(() => this.parent.inProgress = false);
      });
    }

    print('---------');
    print(gain);
    // TODO: implement build
    return ListView(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      children: <Widget>[
        ScreenTitle(title: "Gain and Deposit"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: year.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                fetchData(year[index].substring(0, 4));
                btnColor = [];
                for (var i = 0; i < year.length; i++) {
                  if (i == index) btnColor.add(true);
                  else btnColor.add(false);
                }
                this.parent.setState(() {
                  this.parent.btnColor = btnColor;
                });
              },
              child: ScreenSelect(title: year[index].substring(0, 4) + " Total Gain " + gain[index], color: btnColor[index]),
            ); 
          }
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0)),
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? 200
              : 400,
          child: Column(
            children: <Widget>[
              Table(
                columnWidths: {
                  0: FlexColumnWidth(0.8),
                  1: FlexColumnWidth(flexVal), // - is ok
                  2: FlexColumnWidth(0.6), //- ok as well
                  3: FlexColumnWidth(1),
                },
                children: widgets,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[TableView(homeData: homeData)],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          height: 35.0,
          color: Color(0xFFFF6500),
        ),
        Container(
          height: 100.0,
          color: Colors.black,
          child: Image.asset("images/logo.png"),
        ),
      ],
    );
  }

  /*
* ,
* */
  Widget rowDesign(String name, bool flag) {
    return Container(
      decoration: BoxDecoration(
        color: flag ? Colors.black : Colors.transparent,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 1.0, left: 1),
      child: Text(
        (name == null) ? '-' : name,
        style: TextStyle(
            color: flag ? Colors.white : Colors.white, fontSize: 11.0),
      ),
    );
  }
}

class TableView extends StatelessWidget {
  HomeData homeData;

  TableView({this.homeData});

  List<TableRow> widgets = [];
  var formatter = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).orientation);
    double flexVal = 1.5;
    if (MediaQuery.of(context).orientation == Orientation.portrait &&
        MediaQuery.of(context).size.width <= 320) {
      flexVal = 1.0;
    }
    homeData.tableData.map(
      (TableData data) {
        widgets.add(
          TableRow(
            children: [
              rowDesign(formatter.format(DateTime.parse(data.date)), false, false, context, Alignment.center),
              rowDesign(data.text, false, false, context, Alignment.centerLeft),
              rowDesign(data.amount.toString(), false, false, context,
                  Alignment.centerRight),
              rowPdfDesign(data.account.toString(), false, true, context,
                  data.pdf, Alignment.centerRight)
            ],
          ),
        );
      },
    ).toList();

    // TODO: implement build
    return Table(
      columnWidths: {
        0: FlexColumnWidth(0.8),
        1: FlexColumnWidth(flexVal), // - is ok
        2: FlexColumnWidth(0.6), //- ok as well
        3: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: widgets,
    );
  }

  openPDF(link, BuildContext context) {
    if (link != '') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFview(
                link: link,
              ),
        ),
      );
    }
  }

/*
* ,
* */
  Widget rowDesign(String name, bool flag, bool isPdf, BuildContext context,
      Alignment alignment) {
//    print("PDF $name" );
    return Container(
      decoration: BoxDecoration(
        color: flag ? Colors.grey : Colors.transparent,
      ),
      alignment: alignment,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 1.0, left: 1),
      child: isPdf
          ? name != ''
              ? GestureDetector(
                  onTap: () {
                    openPDF(name, context);
                  },
                  child: Image.asset(
                    "images/pd.png",
                    height: 22.0,
                  ))
              : Container()
          : Text(
              (name == null) ? '-' : name,
              style: TextStyle(
                  color: flag ? Colors.white : Colors.white, fontSize: 11.0),
            ),
    );
  }

  Widget rowPdfDesign(String name, bool flag, bool isPdf, BuildContext context,
      String url, Alignment alignment) {
//    print("PDF $name" );
    return Container(
      decoration: BoxDecoration(
        color: flag ? Colors.grey : Colors.transparent,
      ),
      alignment: alignment,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 1.0, left: 1),
      child: GestureDetector(
        onTap: () {
          openPDF(url, context);
        },
        child: SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                (name == null) ? '-' : name,
                style: TextStyle(
                    color: flag ? Colors.white : Colors.white, fontSize: 12.0),
              ),
              url != ''
                  ? Image.asset(
                      "images/pd.png",
                      height: 20.0,
                      width: 20.0,
                    )
                  : Container(
                      width: 20.0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
