// class CategoryWiseCostBody {
//   List<int> ids;
//   List<double> cost;
//   List<int> isMultiPly;
//
//
//   CategoryWiseCostBody({this.ids, this.cost, this.isMultiPly});
//
//   CategoryWiseCostBody.fromJson(Map<String, dynamic> json) {
//     if (json['ids'] != null) {
//       ids = [];
//       json['ids'].forEach((v) {
//         ids.add(new Cart.fromJson(v));
//       });
//     }
//     password = json['password'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['password'] = this.password;
//     return data;
//   }
// }
