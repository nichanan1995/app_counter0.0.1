class JsonModel {
  // Create Field
  int id;
  String name, trans, licen, barcode;

//   // Constructor
//   JsonModel(
//       int idInt, String nameString, String userString, String passwordString) {
// //     id=idInt;
// // name =nameString;
// // user =userString;
// // password = passwordString;
//   }

  JsonModel(this.id, this.name, this.trans, this.barcode);

  JsonModel.fromJson(Map<String, dynamic> parseJSON) {
    id = int.parse(parseJSON['id']);
    name = parseJSON['Name'];
    licen = parseJSON['Licen'];
    barcode = parseJSON['Barcode'];
  }
}
