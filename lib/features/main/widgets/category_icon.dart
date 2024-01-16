import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryIcon extends StatefulWidget {
  final String category;

  const CategoryIcon({
    super.key,
    required this.category,
  });

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  @override
  Widget build(BuildContext context) {
    return buildContainer(widget.category);
  }

  Widget buildContainer(String category) {
    String categoryLower = category.toLowerCase();
    switch (categoryLower) {
      case 'shopping':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'subscriptions':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'food':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );

      case 'travel':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'others':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'job salary':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/job_salary.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'stipend':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/stipend.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'job bonus':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/job_bonus.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      case 'freelancing':
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/freelancing.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      default:
        return Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/$categoryLower.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
    }
  }
}
