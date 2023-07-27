import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeros/Testing/ui/screens/tab/charity/step_one_screen.dart';
import '../../../../models/charity.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../widgets/charity/category_card.dart';
import '../../../widgets/charity/charity_screen_path.dart';

class StartCharityScreen extends StatelessWidget {
  static var routeName='/start_charity_screen';

  const StartCharityScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kPrimaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      32.r,
                    ),
                    color: Colors.white,
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                          Text(
                            'Start a Recycling',
                            style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Color(0xFF0D732D),
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 90,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 0.7.sw,
                                  child:
                                  Text(
                                    'You can Recycle this',
                                    style:
                                    Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CatrgoryCard(
                              charities[0],
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            CatrgoryCard(
                              charities[1],
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            CatrgoryCard(
                              charities[2],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 125,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 0.7.sw,
                                  child:
                                  Text(
                                    'By track this',
                                    style:
                                    Theme.of(context).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            CatrgoryCard(
                              charities[3],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CatrgoryCard(
                              charities[4],
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 96.h,
                color: Colors.white,
                child: ClipPath(
                  clipper: CharityScreenPath(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColor.kPrimaryColor,
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 72.h,
            left: 0.5.sw - 46.w,
            width: 92.w,
            child: SizedBox(
              width: 92.w,
              height: 92.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  minimumSize: MaterialStateProperty.all(Size(0, 0)),
                  backgroundColor: MaterialStateProperty.all(
                  AppColor.kPrimaryColor,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () =>
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => StepOneScreen())),
                child: Icon(
                  Icons.arrow_forward,
                  size: 48.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
