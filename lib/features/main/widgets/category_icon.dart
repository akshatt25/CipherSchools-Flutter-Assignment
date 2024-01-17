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
            color: const Color.fromARGB(255, 240, 193, 190),
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
            color: const Color.fromARGB(255, 178, 215, 246),
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
            color: const Color.fromARGB(255, 192, 244, 194),
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
            color: const Color.fromARGB(255, 235, 213, 181),
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
            color: const Color.fromARGB(255, 244, 199, 199),
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
            color: Color.fromARGB(255, 240, 235, 186),
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
            color: Color.fromARGB(255, 193, 181, 235),
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
            color: Color.fromARGB(255, 240, 185, 228),
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
            color: Color.fromARGB(255, 188, 242, 247),
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
            color: Color.fromARGB(255, 221, 237, 187),
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
