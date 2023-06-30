class CategoryWiseShippingModel {
  List<AllCategoryShippingCost> allCategoryShippingCost;

  CategoryWiseShippingModel({this.allCategoryShippingCost});

  CategoryWiseShippingModel.fromJson(Map<String, dynamic> json) {
    if (json['all_category_shipping_cost'] != null) {
      allCategoryShippingCost = <AllCategoryShippingCost>[];
      json['all_category_shipping_cost'].forEach((v) {
        allCategoryShippingCost.add(new AllCategoryShippingCost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allCategoryShippingCost != null) {
      data['all_category_shipping_cost'] =
          this.allCategoryShippingCost.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCategoryShippingCost {
  int id;
  int sellerId;
  int categoryId;
  double cost;
  int multiplyQty;
  String createdAt;
  String updatedAt;
  Category category;

  AllCategoryShippingCost(
      {this.id,
        this.sellerId,
        this.categoryId,
        this.cost,
        this.multiplyQty,
        this.createdAt,
        this.updatedAt,
        this.category});

  AllCategoryShippingCost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    categoryId = json['category_id'];
    cost = json['cost'].toDouble();
    if(json['multiply_qty']!=null){
      multiplyQty = int.parse(json['multiply_qty'].toString());
    }else{
      multiplyQty = 0;
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['category_id'] = this.categoryId;
    data['cost'] = this.cost;
    data['multiply_qty'] = this.multiplyQty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  String slug;
  String icon;
  int parentId;
  int position;
  String createdAt;
  String updatedAt;
  int homeStatus;
  int priority;


  Category(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.homeStatus,
        this.priority,
        });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if(json['name']!=null){
      name = json['name'];
    }else{
      name = '';
    }
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    priority = json['priority'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['home_status'] = this.homeStatus;
    data['priority'] = this.priority;
    return data;
  }
}
