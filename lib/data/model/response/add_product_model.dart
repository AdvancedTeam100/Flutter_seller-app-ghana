class AddProductModel{
  List<String> titleList;
  List<String> descriptionList;
  List<String> languageList;
  List<String> colorCodeList;
  List<String> thumbnailList;
  String videoUrl;

  AddProductModel({List<String> titleList, List<String> descriptionList, List<String> languageList, List<String> colorCodeList, List<String> thumbnailList, String videoUrl}){

    this.titleList = titleList;
    this.descriptionList = descriptionList;
    this.languageList = languageList;
    this.colorCodeList = colorCodeList;
    this.thumbnailList = thumbnailList;
    this.videoUrl = videoUrl;




  }


}