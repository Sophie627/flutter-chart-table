import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
//import 'package:fcharts/fcharts.dart';

final bgColor = const Color(0xFFFF6500);

class CustomGraph extends StatefulWidget{

  List<String> x;
  List<double> y;

  CustomGraph({this.x,this.y});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomGraphState();
  }
}


// f-chart
//class CustomGraphState extends State<CustomGraph>{
//  // X value -> Y value
//  List<List<String>> myData = [];
//
////  static const myData = [
////    ["A", "✔"],
////    ["B", "❓"],
////    ["C", "✖"],
////    ["D", "❓"],
////    ["E", "✖"],
////    ["F", "✖"],
////    ["G", "✔"],
////  ];
//
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    for(var i=0; i<widget.x.length; i++){
//     myData.add([widget.x[i].toString(),widget.y[i].toString()+"%"]);
//    }
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    print(myData);
//    return new LineChart(
//
//      lines: [
//        new Line<List<String>, String, String>(
//          data: myData,
//          xFn: (datum) => datum[0],
//          yFn: (datum) => datum[1],
//        ),
//      ],
//      legendPosition: ChartPosition.right,
//      chartPadding: new EdgeInsets.fromLTRB(50.0, 15.0, 30.0, 30.0),
//    );
//  }
//
//}

class CustomGraphState extends State<CustomGraph>{
  LineChartOptions _lineChartOptions;
  ChartOptions _verticalBarChartOptions;
  LabelLayoutStrategy _xContainerLabelLayoutStrategy;
  ChartData _chartData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defineOptionsAndData();
  }

  void defineOptionsAndData() {

    _lineChartOptions = LineChartOptions();
    _verticalBarChartOptions = new VerticalBarChartOptions();
    _chartData = new ChartData();
    _chartData.dataRowsLegends = [''];
    _chartData.dataRowsColors = [bgColor];

    _chartData.dataRows = [
      widget.y
    ];

    _chartData.xLabels = widget.x;
    _chartData.assignDataRowsDefaultColors();
  }


  @override
  Widget build(BuildContext context) {


    defineOptionsAndData();
    LineChart lineChart = new LineChart(

      painter: new LineChartPainter(

      ),

      container: new LineChartContainer(
        chartData: _chartData, // @required
        chartOptions: _lineChartOptions, // @required
      ),
    );
    // TODO: implement build
    return lineChart;
  }
}