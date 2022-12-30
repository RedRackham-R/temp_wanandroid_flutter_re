import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanandroid_flutter_re/global/ext/AppExt.dart';
import 'package:wanandroid_flutter_re/main.dart';

// factory ThemeData({
//     Brightness? brightness,// //调整亮度白天模式和夜间模式
//     VisualDensity? visualDensity,//视觉密度
//     MaterialColor? primarySwatch,//Material风格的组件提供主题色
//     Color? primaryColor,//应用程序主要部分（工具栏、标签栏等）的背景颜色
//     Brightness? primaryColorBrightness,//确定放置在原色之上的文本和图标的颜色如工具栏文本本
//     Color? shadowColor,//小部件的颜色（旋钮、文本、过度滚动边缘效果等）
//     Color? scaffoldBackgroundColor,//页面的背景颜色。
//     Color? bottomAppBarColor,//[BottomAppBar] 的默认颜色。
//     Color? cardColor,//card的颜色
//     Color? dividerColor,//[Divider]s和[PopupMenuDivider]的颜色，使用[ListTile] 之间，
//                         //[DataTable]中的行之间，等等。
//     Color? focusColor,//使用的焦点颜色表示组件具有输入焦点
//     Color? hoverColor,//用于指示指针悬停颜色
//     Color? highlightColor,//选择之后的颜色
//     Color? splashColor,//InkWell点击的水波纹颜色
//     InteractiveInkFeatureFactory? splashFactory,
//     Color? selectedRowColor,//用于突出显示选定行的颜色
//     Color? unselectedWidgetColor,//用于处于非活动状态（但已启用）的小部件的颜色
//     Color? disabledColor,//一个禁用的复选框的颜色
//     ButtonThemeData? buttonTheme,//定义按钮小部件的默认配置，如 [RaisedButton]和 [平面按钮]
//     ToggleButtonsThemeData? toggleButtonsTheme,//定义 [ToggleButtons] 小部件的默认配置
//     Color? backgroundColor,// 与 [primaryColor] 形成对比的颜色，例如 用作进度条的剩余部分
//     Color? dialogBackgroundColor,//[Dialog] 元素的背景颜色
//     Color? indicatorColor,//选项卡栏中选定选项卡指示器的颜色
//     Color? hintColor,// 用于提示文本或占位符文本的颜色，例如 在 [TextField] 字段中
//     Color? errorColor,//用于提示错误信息的文本颜色，例如 在 [TextField] 字段中
//     Color? toggleableActiveColor,//用于突出显示 [Switch]、[Radio] 和 [Checkbox] 等可切换小
//                                  //部件的活动状态的颜色
//     String? fontFamily,//字体
//     TextTheme? textTheme,//颜色与卡片和画布颜色形成对比的文本
//     TextTheme? primaryTextTheme,//与原色形成对比的文本主题
//     InputDecorationTheme? inputDecorationTheme,//[InputDecorator]、[TextField] 的默认
//                           //[InputDecoration] 值，和 [TextFormField] 都是基于这个主题
//     IconThemeData? iconTheme,//与卡片和画布颜色形成对比的图标主题
//     IconThemeData? primaryIconTheme,//与原色形成对比的图标主题
//     SliderThemeData? sliderTheme,//用于渲染 [Slider] 的颜色和形状
//     TabBarTheme? tabBarTheme,//用于自定义标签栏指示器的大小、形状和颜色的主题
//     TooltipThemeData? tooltipTheme,//工具提示主题
//     CardTheme? cardTheme,//用于渲染 [card] 的颜色和样式
//     ChipThemeData? chipTheme,//用于渲染 [Chip] 的颜色和样式
//     TargetPlatform? platform,//设置平台，根据设置的平台会使用此平台的排版样式等
//     MaterialTapTargetSize? materialTapTargetSize,//配置某些 Material 小部件的命中测试大小
//     AppBarTheme? appBarTheme,//自定义[AppBar]的颜色、高度、亮度、iconTheme和textTheme的主题
//     ScrollbarThemeData? scrollbarTheme,//自定义[滚动条]颜色、粗细和形状的主题
//     BottomAppBarTheme? bottomAppBarTheme,//自定义 [BottomAppBar] 的形状、高度和颜色的主题
//     ColorScheme? colorScheme,//这个属性的添加比主题的高度设置晚得多特定颜色，如 [cardColor]、
//                  //[buttonColor]、[canvasColor] 等。新组件可以根据 [colorScheme] 专门定义
//     DialogTheme? dialogTheme,//用于自定义对话框形状的主题
//     FloatingActionButtonThemeData? floatingActionButtonTheme,//用于自定义
//                                   // [FloatingActionButton] 的形状、高度和颜色的主题
//     NavigationBarThemeData? navigationBarTheme,//用于自定义[NavigationBar] 背景颜色、文本样
//                                               //式和图标主题的主题
//     NavigationRailThemeData? navigationRailTheme,//用于自定义 [NavigationRail] 的背景颜色、
//                                                  //高度、文本样式和图标主题的主题
//     SnackBarThemeData? snackBarTheme,//用于自定义 [SnackBar] 的颜色、形状、高度和行为的主题
//     BottomSheetThemeData? bottomSheetTheme,//用于自定义底页颜色、高度和形状的主题
//     PopupMenuThemeData? popupMenuTheme,//用于自定义弹出菜单的颜色、形状、高度和文本样式的主题
//     MaterialBannerThemeData? bannerTheme,//自定义 [MaterialBanner] 的颜色和文本样式的主题
//     DividerThemeData? dividerTheme,//用于自定义[Divider]、[VerticalDivider] 等的颜色、粗细
//                                    //和缩进的主题
//     ButtonBarThemeData? buttonBarTheme,//用于自定义 [ButtonBar] 小部件的外观和布局的主题
//     BottomNavigationBarThemeData? bottomNavigationBarTheme,//BottomNavigationBar外观和布局
//                                                            //的主题
//     TimePickerThemeData? timePickerTheme,//用于自定义 timePicker  外观和布局的主题
//     TextButtonThemeData? textButtonTheme,//用于自定义 [textButton] 外观和布局的主题
//     ElevatedButtonThemeData? elevatedButtonTheme,//[elevatedButton]外观和布局的主题
//     OutlinedButtonThemeData? outlinedButtonTheme,//[outlinedButton]外观和布局的主题
//     DataTableThemeData? dataTableTheme,//用于自定义 [dataTable] 外观和布局的主题
//     CheckboxThemeData? checkboxTheme,//用于自定义 [Checkbox] 小部件的外观和布局的主题
//     RadioThemeData? radioTheme,//用于自定义 [radio] 小部件的外观和布局的主题
//     SwitchThemeData? switchTheme,// 用于自定义 [Switch] 小部件外观和布局的主题
//     ProgressIndicatorThemeData? progressIndicatorTheme,//用于自定义 [ProgressIndicator] 小
//                                                        //部件的外观和布局的主题
//     DrawerThemeData? drawerTheme,//用于自定义 [Drawer] 小部件的外观和布局的主题
//     ListTileThemeData? listTileTheme,// 用于自定义 [ListTile] 小部件外观的主题
//   })
class WanThemes {
  static const List<ColorSwatch> themeColors = <ColorSwatch>[
    Colors.blue,
    Colors.indigo,
    Colors.green,
    Colors.teal,
    Colors.deepOrange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.brown,
    Colors.blueGrey,
  ];

  ///单例创建对象 HomeController 需要持久化 所以不需要每次都创建
  static WanThemes? _instance;

  static WanThemes get instance {
    _instance ??= WanThemes._internal();
    _instance!._init();
    return _instance!;
  }

  WanThemes._internal();

  late ThemeData current;

  ThemeData creatThemeData(Color color, ThemeMode mode) {
    if (mode == ThemeMode.light) {
      return _creatLightTheme(mainColor: color);
    } else {
      return _creatDarkTheme(mainColor: color);
    }
  }

  static Color getThemeColor(int colorValue) {
    for (int i = 0; i < themeColors.length; i++) {
      if (themeColors[i].value == colorValue) {
        return themeColors[i];
      }
    }
    return themeColors[0];
  }


  _init() {
    if (extIsWithSystemMod()) {
      current = extIsPlatformDarkMod()
          ? _creatDarkTheme(
              mainColor: const Color(0xFF121212),
            )
          : _creatLightTheme(
              mainColor: globalAppController.settings.convertThemeColor(),
            );
    } else {
      current = globalAppController.settings.darkMod
          ? _creatDarkTheme(
              mainColor: const Color(0xFF121212),
            )
          : _creatLightTheme(
              mainColor: globalAppController.settings.convertThemeColor(),
            );
    }
  }



  ThemeData _creatDarkTheme({required Color mainColor}) {
    return ThemeData.dark().copyWith(
      iconTheme: const IconThemeData(
        size: 24,
        color: Colors.white,
      ),
      brightness: Brightness.dark,
      indicatorColor: Colors.white,
      primaryColor: mainColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting, backgroundColor: mainColor),
      buttonTheme: ButtonThemeData(
        buttonColor: mainColor, //  <-- dark color
        textTheme:
            ButtonTextTheme.primary, //  <-- this auto selects the right color
      ),
      appBarTheme: AppBarTheme(
        color: mainColor,
      ),
      //无法选中容器颜色 比如TextFormField中的enable为false的情况
      // disabledColor: Colors.transparent,
    );
  }

  ThemeData _creatLightTheme({required Color mainColor}) {
    return ThemeData.light().copyWith(
      iconTheme: const IconThemeData(
        size: 24,
      ),
      brightness: Brightness.light,
      indicatorColor: Colors.white,
      primaryColor: mainColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting, backgroundColor: mainColor),
      buttonTheme: ButtonThemeData(
        buttonColor: mainColor, //  <-- dark color
        textTheme:
            ButtonTextTheme.primary, //  <-- this auto selects the right color
      ),
      appBarTheme: AppBarTheme(
        color: mainColor,
      ),
      //无法选中容器颜色 比如TextFormField中的enable为false的情况
      // disabledColor: Colors.transparent,

      ///----------------------------------正常模式独有---------------------------------

      ///正常主题下switch等按钮颜色跟随主题颜色
      toggleableActiveColor: mainColor,

      ///主题背景颜色
      scaffoldBackgroundColor: const Color(0xFFEEEEEE),
    );
  }

  changeTheme(int colorValue, bool darkMod) {
    if (darkMod) {
      current = _creatDarkTheme(
        mainColor: const Color(0xFF121212),
      );
    } else {
      current = _creatLightTheme(
        mainColor: getThemeColor(colorValue),
      );
    }

    Get.changeTheme(current);
  }
}
