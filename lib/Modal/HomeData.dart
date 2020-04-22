class HomeData {
  Data allTimeProfile;
  Data yearToDate;
  Data lastPeriod;
  List<String> labels;
  String title;
  List<TableData> tableData;

  HomeData({
    this.allTimeProfile,
    this.labels,
    this.lastPeriod,
    this.title,
    this.yearToDate,
    this.tableData,
  });

  factory HomeData.fromJSON(Map<String, dynamic> parsedJson) {
    return HomeData(
      allTimeProfile: Data.fromJSON(parsedJson['all_time_profit']),
      labels: List<String>.from(parsedJson['table_labels']),
      lastPeriod: Data.fromJSON(parsedJson['last_period']),
      title: parsedJson['table_title'],
      yearToDate: Data.fromJSON(parsedJson['year_to_date']),
      tableData: (parsedJson['table_data'] as List).map((m) => new TableData.fromJSON(m)).toList()
    );
  }
}

class Data {
  String label;
  double value;

  Data({
    this.label,
    this.value,
  });

  factory Data.fromJSON(Map<String, dynamic> parsedJson) {
    return Data(
      label: parsedJson['label'],
      value: double.parse(parsedJson['value']),
    );
  }
}

class TableData {
  String date;
  String text;
  String amount;
  String account;
  String pdf;

  TableData({
    this.date,
    this.text,
    this.account,
    this.amount,
    this.pdf,
  });

  factory TableData.fromJSON(Map<String, dynamic> parsedJson) {
    return TableData(
      text: parsedJson['text'],
      account: parsedJson['account'],
      amount: parsedJson['amount'].toString(),
      date: parsedJson['date'],
      pdf: parsedJson['pdf'],
    );
  }
}



class GraphData{
  List<String> x;
  List<String> y;

  GraphData({this.x,this.y});


  factory GraphData.fromJSON(Map<String,dynamic> json){
    return GraphData(
      x: List<String>.from(json['x-axes']),
      y: List<String>.from(json['y-axes'])
    );
  }
}
