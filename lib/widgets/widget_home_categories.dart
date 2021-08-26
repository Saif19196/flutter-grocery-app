import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/api_service.dart';
import 'package:untitled1/models/category.dart'as categoryModel hide Image;

class WidgetCategories extends StatefulWidget{
  @override
  _WidgetCategoriesState createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories>{
  APIService apiService;

  @override
void initSate(){
    apiService = new APIService();
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Padding(padding: EdgeInsets.only(left: 16, top: 10),
          child: Text('All Categories',
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
          ),
          Padding(padding: EdgeInsets.only(left: 16, top: 10, right: 10),
            child: Text('View All',
              style: TextStyle(color: Colors.redAccent),
            ),
          )
            ],
          ),
          _categoriesList()
        ],
      ),
    );
  }

  Widget _categoriesList(){
    return new FutureBuilder(future: apiService.getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<categoryModel.Category>> model, )
        {
          if(model.hasData){
            return _buildCategoryList(model.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
    );
  }
  Widget _buildCategoryList(List<categoryModel.Category> categories){
    return Container(
      height: 150,
      alignment: Alignment.center,
      child: ListView.builder(shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length
          ,itemBuilder:(context,index){
      var data = categories[index];
        return Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: Image.network(
            data.image.url,
            height: 80,
            ),
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
            color: Colors.black12,
            offset: Offset(0,5),
            blurRadius: 15
            ),
            ],
            ),
            ),
            Row(children: [
              Text(data.categoryName.toString()),
          Icon(
          Icons.keyboard_arrow_right,
          size: 14,
          )
          ],)
        ],
        );
      },
      ),
    );
  }
}