import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_forecast/widgets/app_button.dart';

import '../../theme/color.dart';
import '../../theme/styles.dart';
import '../../widgets/app_container.dart';
import '../../widgets/app_form_field.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({
    super.key,
  });

  static const routeName = '/sample_item';

  @override
  Widget builder(
      BuildContext context, DashboardViewModel viewModel, Widget? child) {
    DateFormat dateFormat = DateFormat('EEEE');
    DateFormat datefirst = DateFormat('dd');
    DateFormat datemonth = DateFormat('MMM');
    DateFormat time = DateFormat('hh:mm a');

    // Future<void> showMyDialog(BuildContext context) async {
    //   return showDialog<void>(
    //     context: context,
    //     barrierDismissible: false, // user must tap button!
    //     builder: (BuildContext context) {
    //       return AlertDialog(backgroundColor: Colors.white,
    //         content: SingleChildScrollView(
    //           child: Row(
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Text(
    //                     'Select Anyone',
    //                     style: AppStyle.of(context).slabelBl,
    //                     maxLines: 3,
    //                   ),
    //                   ReactiveForm(
    //                     formGroup: viewModel.form,
    //                     child: AppFormField3(
    //                       label: "Enter City",
    //                       field: ReactiveTextField(
    //                         textCapitalization: TextCapitalization.sentences,
    //                         // onSubmitted: viewModel.getWeatherAPIByCity(),
    //
    //                         // onChanged: viewModel.onOccupationChanged,
    //                         formControlName: viewModel.controls.city,
    //                         keyboardType: TextInputType.text,
    //                         textInputAction: TextInputAction.next,
    //                         decoration: InputDecoration(
    //                           hintText: 'Enter Spouse Name',
    //                           hintStyle: AppStyle.of(context).smediudim,
    //                           border: OutlineInputBorder(
    //                             borderRadius:
    //                             const BorderRadius.all(Radius.circular(4)),
    //                             borderSide: BorderSide(
    //                                 color: AppColors.border, width: 1),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   // Text('Would you like to confirm this message?'),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           // TextButton(
    //           //   child: Text('Yes'),
    //           //   onPressed: () async {
    //           //     await viewModel.deleteAsset(context);
    //           //   },
    //           // ),
    //           TextButton(
    //             child: Text('Exit'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      backgroundColor: const Color(0Xff6ef9e6),
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlueAccent,
      //   title: Text('Weather Forecasting', style: AppStyle.of(context).wlabel13),
      //   actions: [
      //     // IconButton(
      //     //   icon: const Icon(
      //     //     Icons.location_on,
      //     //     color: Colors.white,
      //     //   ),
      //     //   onPressed: () {
      //     //     Navigator.pop(context);
      //     //   },
      //     // ),
      //     // IconButton(
      //     //   icon: const Icon(
      //     //     Icons.grid_view,
      //     //     color: Colors.blue,
      //     //   ),
      //     //   onPressed: () {
      //     //     Navigator.pop(context);
      //     //   },
      //     // ),
      //   ],
      //   leading: IconButton(
      //     icon: const Icon(Icons.location_on),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   systemOverlayStyle: SystemUiOverlayStyle.light, //// Wid
      // ),
      body: Stack(children: [
        SafeArea(
          child: ListView(children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: Color(0Xff2f2e62),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('Use Current Location',
                          style: AppStyle.of(context).style13),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0Xff2f2e62),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  onTap: () => viewModel.getStartLocation(),
                ),
                const SizedBox(
                  height: 50,
                ),
                // CustomAppButton(
                //     text: 'Use My Current Location',
                //     color: CustomBgColor.grey,
                //     onPressed: () async {
                //       viewModel.getStartLocation();
                //     }),
                const SizedBox(
                    child: Icon(
                  Icons.sunny,
                  size: 50,
                  color: Colors.yellow,
                )),
                const SizedBox(
                  height: 10,
                ),
                if (viewModel.weatherData != null &&
                    viewModel.weatherData!.daily != null &&
                    viewModel.weatherData!.daily!.weathercode != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                        "${viewModel.checkWeatherCode(viewModel.weatherData!.daily!.weathercode!.first.toString())}",
                        style: AppStyle.of(context).style18),
                  ),
                const SizedBox(
                  height: 50,
                ),
                if (viewModel.weatherData != null &&
                    viewModel.weatherData!.daily != null &&
                    viewModel.weatherData!.daily!.time != null)
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    child: RefreshIndicator(
                      backgroundColor: AppColors.white,
                      color: AppColors.primary,
                      onRefresh: () => viewModel.getWeatherAPI(),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.weatherData!.daily!.time!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                      "${dateFormat.format(DateTime.parse(viewModel.weatherData!.daily!.sunrise!.elementAt(index).toString()).toLocal())} ",
                                      style: AppStyle.of(context).style13),
                                  Text(
                                      ",${datefirst.format(DateTime.parse(viewModel.weatherData!.daily!.sunrise!.elementAt(index).toString()).toLocal())}",
                                      style: AppStyle.of(context).style13),
                                  Text(
                                      " ${datemonth.format(DateTime.parse(viewModel.weatherData!.daily!.sunrise!.elementAt(index).toString()).toLocal())}",
                                      style: AppStyle.of(context).style13),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color(0Xff95f6f5)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(9),
                                    child: Center(
                                      child: Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            // if (viewModel
                                            //         .weatherData!.daily!.time !=
                                            //     null)
                                            Text(
                                                "${time.format(DateTime.parse(viewModel.weatherData!.daily!.sunrise!.elementAt(index).toString()).toLocal())}",
                                                style: AppStyle.of(context)
                                                    .style13),
                                            const Spacer(),
                                            const Icon(
                                              Icons.sunny_snowing,
                                              size: 28,
                                              color: Color(0Xff2f2e62),
                                            ),
                                            const Spacer(),

                                            Text(
                                                "${viewModel.weatherData!.daily!.weathercode!.elementAt(index).toString()}°",
                                                style: AppStyle.of(context)
                                                    .style22),
                                            const Spacer(),
                                            //
                                            // Text(
                                            //     viewModel
                                            //         .weatherData!.daily!.time!
                                            //         .elementAt(index),
                                            //     style: AppStyle.of(context)
                                            //         .style13),
                                          ]),
                                    ),
                                  ))
                            ]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ]),
        ),
        if (viewModel.showTimestampLoader)
          Container(
            color: AppColors.loaderBgColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.secondary),
                strokeWidth: 5,
              ),
            ),
          ),
      ]),
    );
    // return Scaffold(
    //   backgroundColor: AppColors.black,
    //   appBar: AppBar(
    //     backgroundColor: AppColors.black,
    //     title:
    //         Text('Open High Low Scanner', style: AppStyle.of(context).wlabel14),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(
    //           Icons.question_mark,
    //           color: Colors.blue,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.grid_view,
    //           color: Colors.blue,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //     ],
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     systemOverlayStyle: SystemUiOverlayStyle.light, //// Wid
    //   ),
    //   body: Stack(children: [
    //     SafeArea(
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Row(children: [
    //               const Padding(
    //                 padding: EdgeInsets.all(8.0),
    //                 child: Icon(
    //                   Icons.arrow_back_ios,
    //                   color: Colors.grey,
    //                   size: 22,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   height: MediaQuery.of(context).size.height * 0.07,
    //                   child: ListView(
    //                     scrollDirection: Axis.horizontal,
    //                     children: <Widget>[
    //                       InkWell(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 color: (viewModel.onClick == true)
    //                                     ? Colors.blue[500]
    //                                     : Colors.white70,
    //                                 borderRadius: const BorderRadius.all(
    //                                     Radius.circular(5)),
    //                               ),
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.4,
    //                               child: const Center(
    //                                   child: Text(
    //                                 'Open High + PRB',
    //                                 style: TextStyle(
    //                                     fontSize: 18, color: Colors.white),
    //                               )),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             viewModel.ontabChanged();
    //                           }),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       InkWell(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 color: (viewModel.onSecondClick == true)
    //                                     ? Colors.blue[500]
    //                                     : Colors.white70,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(5)),
    //                               ),
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.4,
    //                               child: const Center(
    //                                   child: Text(
    //                                 'Open Low + PRB',
    //                                 style: TextStyle(
    //                                     fontSize: 18, color: Colors.white),
    //                               )),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             viewModel.ontabSecondtab();
    //                           }),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       InkWell(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 color: (viewModel.onthirdClick == true)
    //                                     ? Colors.blue[500]
    //                                     : Colors.white70,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(5)),
    //                               ),
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.4,
    //                               child: const Center(
    //                                   child: Text(
    //                                 'Open Low',
    //                                 style: TextStyle(
    //                                     fontSize: 18, color: Colors.white),
    //                               )),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             viewModel.onthirdtab();
    //                           }),
    //                       const SizedBox(
    //                         width: 5,
    //                       ),
    //                       InkWell(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 color: (viewModel.onfourthClick == true)
    //                                     ? Colors.blue[500]
    //                                     : Colors.white70,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(5)),
    //                               ),
    //                               width:
    //                                   MediaQuery.of(context).size.width * 0.4,
    //                               child: const Center(
    //                                   child: Text(
    //                                 'Open High',
    //                                 style: TextStyle(
    //                                     fontSize: 18, color: Colors.white),
    //                               )),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             viewModel.onfourthtab();
    //                           }),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Row(
    //                 children: const [
    //                   Padding(
    //                     padding: EdgeInsets.all(8.0),
    //                     child: Icon(
    //                       Icons.arrow_forward_ios,
    //                       color: Colors.grey,
    //                       size: 22,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ]),
    //             Container(
    //               width: MediaQuery.of(context).size.width * 1,
    //               height: MediaQuery.of(context).size.height * 1,
    //               child: RefreshIndicator(
    //                 backgroundColor: AppColors.white,
    //                 color: AppColors.primary,
    //                 onRefresh: () => viewModel.getIntradayData(),
    //                 child: ListView.builder(
    //                     scrollDirection: Axis.vertical,
    //                     itemCount: viewModel.intraday_data.length,
    //                     itemBuilder: (BuildContext context, int index) {
    //                       // List<IntradayScans>? scans = viewModel.intraday_data
    //                       //     .elementAt(index)
    //                       //     .allScans!
    //                       //     .intradayScans;
    //                       return Column(children: [
    //                         const SizedBox(
    //                           height: 15,
    //                         ),
    //                         // if(viewModel.applications.length != null)
    //                         CustomContainer(
    //                           width: MediaQuery.of(context).size.width * 0.9,
    //                           // height: MediaQuery.of(context).size.height * 0.23,
    //                           widget: Padding(
    //                             padding: const EdgeInsets.all(9),
    //                             child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   const SizedBox(
    //                                     height: 10,
    //                                   ),
    //                                   // if (viewModel.intraday_data.isNotEmpty &&)
    //                                   Row(
    //                                     children: [
    //                                       const CircleAvatar(
    //                                         backgroundColor: Colors.white,
    //                                         child: Icon(
    //                                           Icons.compare_outlined,
    //                                           color: Colors.red,
    //                                         ),
    //                                       ),
    //                                       const SizedBox(
    //                                         width: 5,
    //                                       ),
    //                                       Text(
    //                                           "${viewModel.intraday_data.elementAt(index).symbol}",
    //                                           style: AppStyle.of(context)
    //                                               .slabelWt),
    //                                       const Spacer(),
    //                                       viewModel.intraday_data.isNotEmpty &&
    //                                               viewModel.intraday_data
    //                                                       .elementAt(index)
    //                                                       .oiPctChange! <=
    //                                                   0.0
    //                                           ? Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.center,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.center,
    //                                               children: [
    //                                                 Text("OI Ch. %",
    //                                                     style:
    //                                                         AppStyle.of(context)
    //                                                             .slabelG),
    //                                                 const SizedBox(
    //                                                   height: 5,
    //                                                 ),
    //                                                 Row(
    //                                                   children: [
    //                                                     const Icon(
    //                                                       Icons.arrow_drop_down,
    //                                                       color:
    //                                                           Colors.redAccent,
    //                                                       size: 20,
    //                                                     ),
    //                                                     Padding(
    //                                                       padding:
    //                                                           const EdgeInsets
    //                                                               .all(5),
    //                                                       child: Text(
    //                                                           "${viewModel.intraday_data.elementAt(index).oiPctChange}%",
    //                                                           style: AppStyle.of(
    //                                                                   context)
    //                                                               .wlabel13),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ],
    //                                             )
    //                                           : Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.start,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.start,
    //                                               children: [
    //                                                 Text("OI Ch. %",
    //                                                     style:
    //                                                         AppStyle.of(context)
    //                                                             .slabelG),
    //                                                 const SizedBox(
    //                                                   height: 5,
    //                                                 ),
    //                                                 Row(
    //                                                   children: [
    //                                                     const Icon(
    //                                                       Icons
    //                                                           .arrow_drop_up_sharp,
    //                                                       color: Colors
    //                                                           .greenAccent,
    //                                                       size: 20,
    //                                                     ),
    //                                                     Text(
    //                                                         "${viewModel.intraday_data.elementAt(index).oiPctChange}%",
    //                                                         style: AppStyle.of(
    //                                                                 context)
    //                                                             .wlabel13),
    //                                                   ],
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                       const Spacer(),
    //                                       viewModel.intraday_data
    //                                                   .elementAt(index)
    //                                                   .change! <=
    //                                               0.0
    //                                           ? Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.center,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.center,
    //                                               children: [
    //                                                 Text("Change %",
    //                                                     style:
    //                                                         AppStyle.of(context)
    //                                                             .slabelG),
    //                                                 const SizedBox(
    //                                                   height: 5,
    //                                                 ),
    //                                                 Row(
    //                                                   children: [
    //                                                     const Icon(
    //                                                       Icons.arrow_drop_down,
    //                                                       color:
    //                                                           Colors.redAccent,
    //                                                       size: 20,
    //                                                     ),
    //                                                     Text(
    //                                                         "${viewModel.intraday_data.elementAt(index).change} (${viewModel.intraday_data.elementAt(index).change})%",
    //                                                         style: AppStyle.of(
    //                                                                 context)
    //                                                             .wlabelR),
    //                                                   ],
    //                                                 ),
    //                                               ],
    //                                             )
    //                                           : Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.start,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment.center,
    //                                               children: [
    //                                                 Text("Change %",
    //                                                     style:
    //                                                         AppStyle.of(context)
    //                                                             .slabelG),
    //                                                 const SizedBox(
    //                                                   height: 5,
    //                                                 ),
    //                                                 Row(
    //                                                   children: [
    //                                                     const Icon(
    //                                                       Icons
    //                                                           .arrow_drop_up_sharp,
    //                                                       color: Colors
    //                                                           .greenAccent,
    //                                                       size: 20,
    //                                                     ),
    //                                                     Text(
    //                                                         "${viewModel.intraday_data.elementAt(index).change} (${viewModel.intraday_data.elementAt(index).change})%",
    //                                                         style: AppStyle.of(
    //                                                                 context)
    //                                                             .wlabelGr),
    //                                                   ],
    //                                                 ),
    //                                               ],
    //                                             )
    //                                     ],
    //                                   ),
    //
    //                                   const SizedBox(
    //                                     height: 15,
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.center,
    //                                         children: [
    //                                           Text("Today's Range",
    //                                               style: AppStyle.of(context)
    //                                                   .slabelG),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Row(
    //                                             children: [
    //                                               Text(
    //                                                   "${viewModel.intraday_data.elementAt(index).open} -- ${viewModel.intraday_data.elementAt(index).low}",
    //                                                   style:
    //                                                       AppStyle.of(context)
    //                                                           .wlabel13),
    //                                             ],
    //                                           )
    //                                         ],
    //                                       ),
    //                                       const Spacer(),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.center,
    //                                         children: [
    //                                           Text("MOMENTUM",
    //                                               style: AppStyle.of(context)
    //                                                   .slabelG),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Text(
    //                                               "${viewModel.intraday_data.elementAt(index).sectorMomentumRank}",
    //                                               style: AppStyle.of(context)
    //                                                   .wlabel13),
    //                                         ],
    //                                       ),
    //                                       const Spacer(),
    //                                       Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.center,
    //                                         children: [
    //                                           Text("LTP",
    //                                               style: AppStyle.of(context)
    //                                                   .slabelG),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Row(
    //                                             children: [
    //                                               Text(
    //                                                   "${viewModel.intraday_data.elementAt(index).ltp}",
    //                                                   style:
    //                                                       AppStyle.of(context)
    //                                                           .wlabel13),
    //                                               viewModel.intraday_data
    //                                                           .elementAt(index)
    //                                                           .volumePctChange! <=
    //                                                       0.0
    //                                                   ? Text(
    //                                                       "(${viewModel.intraday_data.elementAt(index).volumePctChange}%)",
    //                                                       style: AppStyle.of(
    //                                                               context)
    //                                                           .wlabelR)
    //                                                   : Text(
    //                                                       "(${viewModel.intraday_data.elementAt(index).volumePctChange}%)",
    //                                                       style: AppStyle.of(
    //                                                               context)
    //                                                           .wlabelGr),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   const SizedBox(
    //                                     height: 15,
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       const Spacer(),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.green[800],
    //                                           borderRadius:
    //                                               const BorderRadius.all(
    //                                                   Radius.circular(5)),
    //                                         ),
    //                                         child: Row(
    //                                           children: [
    //                                             Padding(
    //                                               padding:
    //                                                   const EdgeInsets.only(
    //                                                       left: 12,
    //                                                       right: 12,
    //                                                       top: 5,
    //                                                       bottom: 5),
    //                                               child: Text(
    //                                                   "${viewModel.intraday_data.elementAt(index).openHighLowSignal}",
    //                                                   style:
    //                                                       AppStyle.of(context)
    //                                                           .wlabel13),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       // const Spacer(),
    //                                       SizedBox(
    //                                         width: 5,
    //                                       ),
    //                                       Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Colors.green[800],
    //                                           borderRadius:
    //                                               const BorderRadius.all(
    //                                                   Radius.circular(5)),
    //                                         ),
    //                                         child: Row(
    //                                           children: [
    //                                             Padding(
    //                                               padding:
    //                                                   const EdgeInsets.only(
    //                                                       left: 12,
    //                                                       right: 12,
    //                                                       top: 5,
    //                                                       bottom: 5),
    //                                               child: Text(
    //                                                   "${viewModel.intraday_data.elementAt(index).prb}",
    //                                                   style:
    //                                                       AppStyle.of(context)
    //                                                           .wlabel13),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ]),
    //                           ),
    //                         ),
    //                       ]);
    //                     }),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     if (viewModel.showTimestampLoader)
    //       Container(
    //         color: AppColors.loaderBgColor,
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height,
    //         child: const Center(
    //           child: CircularProgressIndicator(
    //             valueColor: AlwaysStoppedAnimation(AppColors.secondary),
    //             strokeWidth: 5,
    //           ),
    //         ),
    //       ),
    //   ]),
    // );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();
}
