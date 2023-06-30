class ProductModel {
  int totalSize;
  int limit;
  int offset;
  List<Product> _products;

  ProductModel(
      {int totalSize, int limit, int offset, List<Product> products}) {
    this.totalSize = totalSize;
    this.limit = limit;
    this.offset = offset;
    this._products = products;
  }

  List<Product> get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = int.parse(json['limit'].toString());
    offset = int.parse(json['offset'].toString());
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  String productType;
  String code;
  int brandId;
  List<CategoryIds> categoryIds;
  String unit;
  List<String> images;
  String thumbnail;
  List<ProductColors> colors;
  List<int> attributes;
  List<ChoiceOptions> choiceOptions;
  List<Variation> variation;
  double unitPrice;
  double purchasePrice;
  double tax;
  String taxModel;
  int minQty;
  String taxType;
  double discount;
  String discountType;
  int currentStock;
  String details;
  String createdAt;
  String updatedAt;
  int status;
  int requestStatus;
  List<Rating> rating;
  String metaTitle;
  String metaDescription;
  String metaImage;
  double shippingCost;
  int multiplyWithQuantity;
  int minimumOrderQty;
  String digitalProductType;
  String digitalFileReady;
  int reviewsCount;
  String averageReview;
  List<Reviews> reviews;
  String deniedNote;
  List<Tags> tags;


  Product(
      {int id,
        String addedBy,
        int userId,
        String name,
        String slug,
        String productType,
        String code,
        int brandId,
        List<CategoryIds> categoryIds,
        String unit,
        int minQty,
        List<String> images,
        String thumbnail,
        List<ProductColors> colors,
        String variantProduct,
        List<int> attributes,
        List<ChoiceOptions> choiceOptions,
        List<Variation> variation,
        double unitPrice,
        double purchasePrice,
        double tax,
        String taxModel,
        String taxType,
        double discount,
        String discountType,
        int currentStock,
        String details,
        String attachment,
        String createdAt,
        String updatedAt,
        int status,
        int requestStatus,
        int featuredStatus,
        List<Rating> rating,
        String metaTitle,
        String metaDescription,
        String metaImage,
        double shippingCost,
        int multiplyWithQuantity,
        int minimumOrderQty,
        String digitalProductType,
        String digitalFileReady,
        int reviewsCount,
        String averageReview,
        List<Reviews> reviews,
        String deniedNote,
        List<Tags> tags,
      }) {
    this.id = id;
    this.addedBy = addedBy;
    this.userId = userId;
    this.name = name;
    this.slug = slug;
    this.productType = productType;
    this.code = code;
    this.brandId = brandId;
    this.categoryIds = categoryIds;
    this.unit = unit;
    this.minQty = minQty;
    this.images = images;
    this.thumbnail = thumbnail;
    this.colors = colors;
    this.attributes = attributes;
    this.choiceOptions = choiceOptions;
    this.variation = variation;
    this.unitPrice = unitPrice;
    this.purchasePrice = purchasePrice;
    this.tax = tax;
    this.taxModel = taxModel;
    this.taxType = taxType;
    this.discount = discount;
    this.discountType = discountType;
    this.currentStock = currentStock;
    this.details = details;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.status = status;
    this.requestStatus = requestStatus;
    this.rating = rating;
    this.metaTitle = metaTitle;
    this.metaDescription = metaDescription;
    this.metaImage = metaImage;
    this.shippingCost = shippingCost;
    this.multiplyWithQuantity = multiplyWithQuantity;
    this.minimumOrderQty = minimumOrderQty;
    if (digitalProductType != null) {
      this.digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      this.digitalFileReady = digitalFileReady;
    }
    if (reviewsCount != null) {
      this.reviewsCount = reviewsCount;
    }
    if (averageReview != null) {
      this.averageReview = averageReview;
    }
    if (reviews != null) {
      this.reviews = reviews;
    }
    if (deniedNote != null) {
      this.deniedNote = deniedNote;
    }
    if (tags != null) {
      this.tags = tags;
    }

  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    code = json['code'];
    brandId = json['brand_id'];
    if (json['category_ids'] != null) {
      categoryIds = [];
      json['category_ids'].forEach((v) {
        categoryIds.add(new CategoryIds.fromJson(v));
      });
    }
    unit = json['unit'];
    minQty = json['min_qty'];
    if(json['images'] != null){
      images = json['images'] != null ? json['images'].cast<String>() : [];
    }

    thumbnail = json['thumbnail'];
    if (json['colors_formatted'] != null) {
      colors = [];
      json['colors_formatted'].forEach((v) {
        colors.add(new ProductColors.fromJson(v));
      });
    }
    if(json['attributes'] != null) {
      attributes = [];
      for(int index=0; index<json['attributes'].length; index++) {
        attributes.add(int.parse(json['attributes'][index].toString()));
      }
    }
    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {
        choiceOptions.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = [];
      json['variation'].forEach((v) {
        variation.add(new Variation.fromJson(v));
      });
    }
    unitPrice = json['unit_price'].toDouble();
    purchasePrice = json['purchase_price'].toDouble();
    tax = json['tax'].toDouble();
    taxModel = json['tax_model'];
    taxType = json['tax_type'];
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    if(json['request_status'] != null){
      try{
        requestStatus = json['request_status'];
      }catch(e){
        requestStatus = int.parse(json['request_status']);
      }

    }
    deniedNote = json['denied_note'];


    if (json['rating'] != null) {
      rating = [];
      json['rating'].forEach((v) {
        rating.add(new Rating.fromJson(v));
      });
    }
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    if(json['shipping_cost']!=null){
      shippingCost = json['shipping_cost'].toDouble();
    }
    if(json['multiply_qty']!=null){
      multiplyWithQuantity = json['multiply_qty'];
    }
    if(json['minimum_order_qty']!=null){
      try{
        minimumOrderQty = json['minimum_order_qty'];
      }catch(e){
        minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
      }

    }
    if(json['digital_product_type']!=null){
      digitalProductType = json['digital_product_type'];
    }
    if(json['digital_file_ready']!=null){
      digitalFileReady = json['digital_file_ready'];
    }
    reviewsCount = int.parse(json['reviews_count'].toString());
    averageReview = json['average_review'].toString();
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    data['code'] = this.code;
    data['brand_id'] = this.brandId;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds.map((v) => v.toJson()).toList();
    }
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['images'] = this.images;
    data['thumbnail'] = this.thumbnail;
    if (this.colors != null) {
      data['colors_formatted'] = this.colors.map((v) => v.toJson()).toList();
    }
    data['attributes'] = this.attributes;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_model'] = this.taxModel;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['denied_note'] = this.deniedNote;
    data['request_status'] = this.requestStatus;
    if (this.rating != null) {
      data['rating'] = this.rating.map((v) => v.toJson()).toList();
    }
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['shipping_cost'] = this.shippingCost;
    data['multiply_qty'] = this.multiplyWithQuantity;
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['digital_product_type'] = this.digitalProductType;
    data['digital_file_ready'] = this.digitalFileReady;
    data['reviews_count'] = this.reviewsCount;
    data['average_review'] = this.averageReview;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryIds {
  String id;
  int position;

  CategoryIds({String id, int position}) {
    this.id = id;
    this.position = position;
  }


  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    return data;
  }
}

class ProductColors {
  String _name;
  String _code;

  ProductColors({String name, String code}) {
    this._name = name;
    this._code = code;
  }

  String get name => _name;
  String get code => _code;

  ProductColors.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['code'] = this._code;
    return data;
  }
}

class ChoiceOptions {
  String _name;
  String _title;
  List<String> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name;
  String get title => _title;
  List<String> get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class Variation {
  String _type;
  double _price;
  String _sku;
  int _qty;

  Variation({String type, double price, String sku, int qty}) {
    this._type = type;
    this._price = price;
    this._sku = sku;
    this._qty = qty;
  }

  String get type => _type;
  double get price => _price;
  String get sku => _sku;
  int get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['price'] = this._price;
    data['sku'] = this._sku;
    data['qty'] = this._qty;
    return data;
  }
}

class Rating {
  String _average;
  int _productId;

  Rating({String average, int productId}) {
    this._average = average;
    this._productId = productId;
  }

  String get average => _average;
  int get productId => _productId;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'].toString();
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this._average;
    data['product_id'] = this._productId;
    return data;
  }
}

class Reviews {
  int _id;
  int _productId;
  int _customerId;
  String _comment;
  String _attachment;
  int _rating;
  int _status;
  String _createdAt;
  String _updatedAt;
  Customer _customer;

  Reviews(
      {int id,
        int productId,
        int customerId,
        String comment,
        String attachment,
        int rating,
        int status,
        String createdAt,
        String updatedAt,
        Customer customer}) {
    if (id != null) {
      this._id = id;
    }
    if (productId != null) {
      this._productId = productId;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (comment != null) {
      this._comment = comment;
    }
    if (attachment != null) {
      this._attachment = attachment;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (status != null) {
      this._status = status;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (customer != null) {
      this._customer = customer;
    }
  }

  int get id => _id;
  int get productId => _productId;
  int get customerId => _customerId;
  String get comment => _comment;
  String get attachment => _attachment;
  int get rating => _rating;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Customer get customer => _customer;


  Reviews.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _customerId = json['customer_id'];
    _comment = json['comment'];
    _attachment = json['attachment'];
    _rating = json['rating'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['customer_id'] = this._customerId;
    data['comment'] = this._comment;
    data['attachment'] = this._attachment;
    data['rating'] = this._rating;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._customer != null) {
      data['customer'] = this._customer.toJson();
    }
    return data;
  }
}

class Customer {
  int _id;
  String _fName;
  String _lName;
  String _phone;
  String _image;
  String _email;

  Customer(
      {int id,
        String fName,
        String lName,
        String phone,
        String image,
        String email,
      }) {
    if (id != null) {
      this._id = id;
    }
    if (fName != null) {
      this._fName = fName;
    }
    if (lName != null) {
      this._lName = lName;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (image != null) {
      this._image = image;
    }
    if (email != null) {
      this._email = email;
    }

  }

  int get id => _id;
  String get fName => _fName;
  String get lName => _lName;
  String get phone => _phone;
  String get image => _image;
  String get email => _email;


  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['image'] = this._image;
    data['email'] = this._email;

    return data;
  }
}

class Tags {
  int id;
  String tag;


  Tags({this.id, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    return data;
  }
}

