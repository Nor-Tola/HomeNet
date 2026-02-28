class Widgetdata {
  int number;
  String name;
  Widgetdata({required this.number, required this.name});
}

class WidgetData1{
  int number;
  String name;
  String icon;
  WidgetData1({required this.number, required this.name, required this.icon});
}

List<Widgetdata> widgetList = [
  Widgetdata(number: 0, name: "Active"),
  Widgetdata(number: 0, name: "Sensers"),
  Widgetdata(number: 0, name: "Alert")
];

List<WidgetData1> widgetList1 = [
  WidgetData1(number: 0, name: 'Living Room', icon: '🌡️'),
  WidgetData1(number: 0, name: 'Humidity', icon: '💧'),
];