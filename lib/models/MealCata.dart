

class MealCata{
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;


  MealCata({
    required this.strCategory,
    required this.strCategoryDescription,
    required this.strCategoryThumb
  });


  factory MealCata.fromjson(Map<String, dynamic> json){
    return MealCata(
        strCategory: json['strCategory'],
        strCategoryDescription: json['strCategoryDescription'],
        strCategoryThumb: json['strCategoryThumb']
    );
  }


}