import 'package:flutter/material.dart';

const mainAppName = 'MNS';

// Colors in the app
const kPrimaryColor = Color(0XFF325BF0);
const kSecondaryColor = Color(0xFF2a3042);
const kSelectedrawerColor = Color(0XFFF2ECFD);
const kButtonColor = Color(0x8affffff);
const kTextColor = Color(0xffCAD5E2);
const kBlackColor = Color(0XFF130925);
const kLightBlack = Color(0xff343434);
const kBackgroundColor = Color(0xffF4BE2C);
const kSearchBarColor = Color(0xffD6D6D6);
const kIconColor = Color(0xff7b1fa2);
const kLightGreyColor = Color(0xffe0e0e0);
const kWhiteColor = Color(0xffffffff);
const kGreyColor = Color(0XFFBABFB6);
const kDarkGreyColor = Color(0xff757575);

// Normal  text Syle

const TextStyle kXSmallTextStyle =
    TextStyle(color: kBlackColor, fontSize: kTextSiseXSmallText);
const TextStyle kSmallTextStyle =
    TextStyle(color: kBlackColor, fontSize: kTextSizeSmall);
const TextStyle kMediumTextStyle =
    TextStyle(color: kBlackColor, fontSize: kTextSizeSMedium);

const TextStyle kLTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: kTextSizeLargeMedium,
);

const TextStyle kXLTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: kTextSizeLargeMedium,
);

const TextStyle kDXLTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: 20,
);

// white normal size Text style

const TextStyle kWhiteSmlTextStyle =
    TextStyle(color: kWhiteColor, fontSize: kTextSiseXSmallText);
const TextStyle kWhiteMdmTextStyle =
    TextStyle(color: kWhiteColor, fontSize: kTextSizeSmall);

const TextStyle kWhiteLrgTextStyle = TextStyle(
    color: kWhiteColor, fontSize: kTextSizeMedium, fontWeight: FontWeight.w500);

const TextStyle kWtXtaTstSte =
    TextStyle(color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w500);

// Red color text
const TextStyle kCAtStyle =
    TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w500);
const TextStyle kLCAtStyle = TextStyle(
    color: Colors.red, fontSize: kTextSizeSMedium, fontWeight: FontWeight.w500);

//weight500 bold textStyle
const TextStyle kBSTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: kTextSiseXSmallText,
    fontWeight: FontWeight.w500);

const TextStyle kBMTextStyle = TextStyle(
    color: kBlackColor, fontSize: kTextSizeSmall, fontWeight: FontWeight.w500);
const TextStyle kBLTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: kTextSizeSMedium,
    fontWeight: FontWeight.bold);
const TextStyle kBXLTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: kTextSizeLargeMedium,
    fontWeight: FontWeight.bold);
const TextStyle kDBXLTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: kTextSizeLargeMedium,
    fontWeight: FontWeight.bold);

// bold text
const TextStyle kDataCellTextStyle =
    TextStyle(color: kBlackColor, fontSize: 16);

const TextStyle kDataTableTextStyle =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.bold, fontSize: 16);

const TextStyle kWSTextStyle = TextStyle(
    color: kPrimaryColor,
    fontSize: kTextSiseXSmallText,
    fontWeight: FontWeight.w500);

const TextStyle kWMTextStyle = TextStyle(
    color: kPrimaryColor,
    fontSize: kTextSizeSmall,
    fontWeight: FontWeight.w500);
const TextStyle kWLTextStyle = TextStyle(
    color: kPrimaryColor,
    fontSize: kTextSizeSMedium,
    fontWeight: FontWeight.w500);
const TextStyle kWXLTextStyle = TextStyle(
    color: kPrimaryColor,
    fontSize: kTextSizeLargeMedium,
    fontWeight: FontWeight.w500);
const TextStyle kWBXLTextStyle = TextStyle(
    color: kPrimaryColor,
    fontSize: kTextSizeLargeMedium,
    fontWeight: FontWeight.w500);

//label test
const TextStyle kLabelTextStyle = TextStyle(
  color: kBlackColor,
  fontSize: kTextSizeSMedium,
);

const TextStyle ktextFieldText =
    TextStyle(color: kLightBlack, fontSize: kTextSizeSMedium);

//black  000000 444444 666666 and similar variants
//grey grey 959595 E5E5E5 9C9C9C CFCECEgrey 959595 E5E5E5 9C9C9C CFCECE

// test style
/* font sizes*/
const double kTextSiseXSmallText = 10.0;
const double kTextSizeSmall = 12.0;
const double kTextSizeSMedium = 14.0;
const double kTextSizeMedium = 16.0;
const double kTextSizeLargeMedium = 18.0;
const double kTextSizeNormal = 20.0;
const double kTextSizeLarge = 24.0;
const double kTextSizeXLarge = 30.0;
const double kTextSizeXXLarge = 35.0;
// padding
const double kDefaultPadding = 15.0;

const double kwidth = 80;

// display mediaquery size

Size displaySize(BuildContext context) {
  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;
}

// when no data get from the api

// const String SUCCESS_MESSAGE=" You will be contacted by us very soon.";
const String kNoimageFound = "assets/images/noImageFound.jpg";
const String kDataNotFond = "No data Found";

// fixed Sized box
const double xsmlheight = 4.0;
const double smlheight = 6.0;
const double height = 10.0;
const double mdimheight = 12.0;
const double extraheight = 14.0;
const double dxxlheight = 16.0;

const SizedBox smlsizebox = SizedBox(height: smlheight);
const SizedBox normalsizebox = SizedBox(height: height);
const SizedBox largesizebox = SizedBox(height: mdimheight);
const SizedBox extrasizebox = SizedBox(height: extraheight);
