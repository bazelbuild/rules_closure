# DO NOT EDIT -- bazel run //closure/library:regenerate -- "$PWD"

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("//closure:defs.bzl", "closure_js_library")

closure_js_library(
    name = "all_js",
    exports = [
        ":abstractspellchecker",
        ":activitymonitor",
        ":advancedtooltip",
        ":animatedzippy",
        ":attachablemenu",
        ":bidiinput",
        ":bubble",
        ":button",
        ":buttonrenderer",
        ":buttonside",
        ":charcounter",
        ":charpicker",
        ":checkbox",
        ":checkboxmenuitem",
        ":checkboxrenderer",
        ":colormenubutton",
        ":colormenubuttonrenderer",
        ":colorpalette",
        ":colorpicker",
        ":combobox",
        ":component",
        ":componentutil",
        ":container",
        ":containerrenderer",
        ":containerscroller",
        ":control",
        ":controlcontent",
        ":controlrenderer",
        ":cookieeditor",
        ":css3buttonrenderer",
        ":css3menubuttonrenderer",
        ":cssnames",
        ":custombutton",
        ":custombuttonrenderer",
        ":customcolorpalette",
        ":datepicker",
        ":datepickerrenderer",
        ":decorate",
        ":defaultdatepickerrenderer",
        ":dialog",
        ":dimensionpicker",
        ":dimensionpickerrenderer",
        ":dragdropdetector",
        ":drilldownrow",
        ":filteredmenu",
        ":filterobservingmenuitem",
        ":filterobservingmenuitemrenderer",
        ":flatbuttonrenderer",
        ":flatmenubuttonrenderer",
        ":formpost",
        ":gauge",
        ":gaugetheme",
        ":hovercard",
        ":hsvapalette",
        ":hsvpalette",
        ":idgenerator",
        ":idletimer",
        ":iframemask",
        ":imagelessbuttonrenderer",
        ":imagelessmenubuttonrenderer",
        ":inputdatepicker",
        ":itemevent",
        ":keyboardshortcuthandler",
        ":labelinput",
        ":linkbuttonrenderer",
        ":menu",
        ":menubar",
        ":menubardecorator",
        ":menubarrenderer",
        ":menubase",
        ":menubutton",
        ":menubuttonrenderer",
        ":menuheader",
        ":menuheaderrenderer",
        ":menuitem",
        ":menuitemrenderer",
        ":menurenderer",
        ":menuseparator",
        ":menuseparatorrenderer",
        ":mockactivitymonitor",
        ":modalariavisibilityhelper",
        ":modalpopup",
        ":nativebuttonrenderer",
        ":option",
        ":palette",
        ":paletterenderer",
        ":plaintextspellchecker",
        ":popup",
        ":popupbase",
        ":popupcolorpicker",
        ":popupdatepicker",
        ":popupmenu",
        ":progressbar",
        ":prompt",
        ":rangemodel",
        ":ratings",
        ":registry",
        ":richtextspellchecker",
        ":roundedpanel",
        ":roundedtabrenderer",
        ":scrollfloater",
        ":select",
        ":selectionmenubutton",
        ":selectionmodel",
        ":separator",
        ":serverchart",
        ":slider",
        ":sliderbase",
        ":splitpane",
        ":submenu",
        ":submenurenderer",
        ":tab",
        ":tabbar",
        ":tabbarrenderer",
        ":tablesorter",
        ":tabpane",
        ":tabrenderer",
        ":textarea",
        ":textarearenderer",
        ":togglebutton",
        ":toolbar",
        ":toolbarbutton",
        ":toolbarbuttonrenderer",
        ":toolbarcolormenubutton",
        ":toolbarcolormenubuttonrenderer",
        ":toolbarmenubutton",
        ":toolbarmenubuttonrenderer",
        ":toolbarrenderer",
        ":toolbarselect",
        ":toolbarseparator",
        ":toolbarseparatorrenderer",
        ":toolbartogglebutton",
        ":tooltip",
        ":tristatemenuitem",
        ":tristatemenuitemrenderer",
        ":twothumbslider",
        ":zippy",
        "//closure/library/ui/ac:all_js",
        "//closure/library/ui/editor:all_js",
        "//closure/library/ui/emoji:all_js",
        "//closure/library/ui/media:all_js",
        "//closure/library/ui/style/app:all_js",
        "//closure/library/ui/tree:all_js",
    ],
)

closure_js_library(
    name = "abstractspellchecker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/abstractspellchecker.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:selection",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtype",
        "//closure/library/math:coordinate",
        "//closure/library/spell:spellcheck",
        "//closure/library/structs:set",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:menuseparator",
        "//closure/library/ui:popupmenu",
    ],
)

closure_js_library(
    name = "activitymonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/activitymonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
    ],
)

closure_js_library(
    name = "advancedtooltip",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/advancedtooltip.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/math:box",
        "//closure/library/math:coordinate",
        "//closure/library/style",
        "//closure/library/ui:tooltip",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "animatedzippy",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/animatedzippy.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/fx:animation",
        "//closure/library/fx:easing",
        "//closure/library/fx:transition",
        "//closure/library/ui:zippy",
    ],
)

closure_js_library(
    name = "attachablemenu",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/attachablemenu.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events:event",
        "//closure/library/events:keycodes",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:itemevent",
        "//closure/library/ui:menubase",
        "//closure/library/ui:popupbase",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "bidiinput",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/bidiinput.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:inputhandler",
        "//closure/library/i18n:bidi",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "bubble",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/bubble.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:safe",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/html:safehtml",
        "//closure/library/math:box",
        "//closure/library/positioning",
        "//closure/library/positioning:absoluteposition",
        "//closure/library/positioning:anchoredposition",
        "//closure/library/string:const",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:popup",
    ],
)

closure_js_library(
    name = "button",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/button.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/ui:buttonrenderer",
        "//closure/library/ui:buttonside",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:nativebuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "buttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/buttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/ui:buttonside",
        "//closure/library/ui:component",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "buttonside",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/buttonside.js"],
    lenient = True,
)

closure_js_library(
    name = "charcounter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/charcounter.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/events:inputhandler",
    ],
)

closure_js_library(
    name = "charpicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/charpicker.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:inputhandler",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/i18n:charlistdecompressor",
        "//closure/library/i18n:charpickerdata",
        "//closure/library/i18n:uchar",
        "//closure/library/i18n/uchar:namefetcher",
        "//closure/library/structs:set",
        "//closure/library/style",
        "//closure/library/ui:button",
        "//closure/library/ui:component",
        "//closure/library/ui:containerscroller",
        "//closure/library/ui:flatbuttonrenderer",
        "//closure/library/ui:hovercard",
        "//closure/library/ui:labelinput",
        "//closure/library/ui:menu",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:tooltip",
    ],
)

closure_js_library(
    name = "checkbox",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/checkbox.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/string",
        "//closure/library/ui:checkboxrenderer",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "checkboxmenuitem",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/checkboxmenuitem.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "checkboxrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/checkboxrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "colormenubutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/colormenubutton.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/object",
        "//closure/library/ui:colormenubuttonrenderer",
        "//closure/library/ui:colorpalette",
        "//closure/library/ui:component",
        "//closure/library/ui:menu",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "colormenubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/colormenubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/color",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:menubuttonrenderer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "colorpalette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/colorpalette.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/color",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:palette",
        "//closure/library/ui:paletterenderer",
    ],
)

closure_js_library(
    name = "colorpicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/colorpicker.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:colorpalette",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "combobox",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/combobox.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/events:inputhandler",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/log",
        "//closure/library/positioning",
        "//closure/library/positioning:menuanchoredposition",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:itemevent",
        "//closure/library/ui:labelinput",
        "//closure/library/ui:menu",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:menuseparator",
        "//closure/library/ui:registry",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "component",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/component.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/object",
        "//closure/library/style",
        "//closure/library/ui:idgenerator",
    ],
)

closure_js_library(
    name = "componentutil",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/componentutil.js"],
    lenient = True,
    deps = ["//closure/library/events:eventtype"],
)

closure_js_library(
    name = "container",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/container.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/object",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:componentutil",
        "//closure/library/ui:containerrenderer",
        "//closure/library/ui:control",
    ],
)

closure_js_library(
    name = "containerrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/containerrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:registry",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "containerscroller",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/containerscroller.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/events:eventhandler",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:container",
    ],
)

closure_js_library(
    name = "control",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/control.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/events:browserevent",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/string",
        "//closure/library/ui:component",
        "//closure/library/ui:componentutil",
        "//closure/library/ui:controlcontent",
        "//closure/library/ui:controlrenderer",
        "//closure/library/ui:registry",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "controlcontent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/controlcontent.js"],
    lenient = True,
)

closure_js_library(
    name = "controlrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/controlrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/object",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:controlcontent",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "cookieeditor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/cookieeditor.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/net:cookies",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "css3buttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/css3buttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:button",
        "//closure/library/ui:buttonrenderer",
        "//closure/library/ui:component",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "css3menubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/css3menubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menubuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "cssnames",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/cssnames.js"],
    lenient = True,
)

closure_js_library(
    name = "custombutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/custombutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:button",
        "//closure/library/ui:custombuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "custombuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/custombuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/string",
        "//closure/library/ui:buttonrenderer",
        "//closure/library/ui:cssnames",
    ],
)

closure_js_library(
    name = "customcolorpalette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/customcolorpalette.js"],
    lenient = True,
    deps = [
        "//closure/library/color",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:colorpalette",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "datepicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/datepicker.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/date",
        "//closure/library/date:daterange",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/events:event",
        "//closure/library/events:eventtype",
        "//closure/library/events:keyhandler",
        "//closure/library/i18n:datetimeformat",
        "//closure/library/i18n:datetimepatterns",
        "//closure/library/i18n:datetimesymbols",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:defaultdatepickerrenderer",
        "//closure/library/ui:idgenerator",
    ],
)

closure_js_library(
    name = "datepickerrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/datepickerrenderer.js"],
    lenient = True,
)

closure_js_library(
    name = "decorate",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/decorate.js"],
    lenient = True,
    deps = ["//closure/library/ui:registry"],
)

closure_js_library(
    name = "defaultdatepickerrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/defaultdatepickerrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:datepickerrenderer",
    ],
)

closure_js_library(
    name = "dialog",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/dialog.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/fx:dragger",
        "//closure/library/html:safehtml",
        "//closure/library/math:rect",
        "//closure/library/string",
        "//closure/library/structs:map",
        "//closure/library/style",
        "//closure/library/ui:modalpopup",
    ],
)

closure_js_library(
    name = "dimensionpicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/dimensionpicker.js"],
    lenient = True,
    deps = [
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/math:size",
        "//closure/library/ui:component",
        "//closure/library/ui:componentutil",
        "//closure/library/ui:control",
        "//closure/library/ui:dimensionpickerrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "dimensionpickerrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/dimensionpickerrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:announcer",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/i18n:bidi",
        "//closure/library/style",
        "//closure/library/ui:controlrenderer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "dragdropdetector",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/dragdropdetector.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/math:coordinate",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "drilldownrow",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/drilldownrow.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/string",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "filteredmenu",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/filteredmenu.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:inputhandler",
        "//closure/library/events:keycodes",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:filterobservingmenuitem",
        "//closure/library/ui:menu",
        "//closure/library/ui:menuitem",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "filterobservingmenuitem",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/filterobservingmenuitem.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:filterobservingmenuitemrenderer",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "filterobservingmenuitemrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/filterobservingmenuitemrenderer.js"],
    lenient = True,
    deps = ["//closure/library/ui:menuitemrenderer"],
)

closure_js_library(
    name = "flatbuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/flatbuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:button",
        "//closure/library/ui:buttonrenderer",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "flatmenubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/flatmenubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:flatbuttonrenderer",
        "//closure/library/ui:menu",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menurenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "formpost",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/formpost.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/html:safehtml",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "gauge",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/gauge.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/fx:animation",
        "//closure/library/fx:easing",
        "//closure/library/fx:transition",
        "//closure/library/graphics",
        "//closure/library/graphics:font",
        "//closure/library/graphics:path",
        "//closure/library/graphics:solidfill",
        "//closure/library/math",
        "//closure/library/ui:component",
        "//closure/library/ui:gaugetheme",
    ],
)

closure_js_library(
    name = "gaugetheme",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/gaugetheme.js"],
    lenient = True,
    deps = [
        "//closure/library/graphics:lineargradient",
        "//closure/library/graphics:solidfill",
        "//closure/library/graphics:stroke",
    ],
)

closure_js_library(
    name = "hovercard",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/hovercard.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtype",
        "//closure/library/ui:advancedtooltip",
        "//closure/library/ui:popupbase",
        "//closure/library/ui:tooltip",
    ],
)

closure_js_library(
    name = "hsvapalette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/hsvapalette.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/color:alpha",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:hsvpalette",
    ],
)

closure_js_library(
    name = "hsvpalette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/hsvpalette.js"],
    lenient = True,
    deps = [
        "//closure/library/color",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:inputhandler",
        "//closure/library/style",
        "//closure/library/style:bidi",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "idgenerator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/idgenerator.js"],
    lenient = True,
)

closure_js_library(
    name = "idletimer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/idletimer.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:eventtarget",
        "//closure/library/structs:set",
        "//closure/library/timer",
        "//closure/library/ui:activitymonitor",
    ],
)

closure_js_library(
    name = "iframemask",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/iframemask.js"],
    lenient = True,
    deps = [
        "//closure/library/disposable",
        "//closure/library/dom",
        "//closure/library/dom:iframe",
        "//closure/library/events:eventhandler",
        "//closure/library/structs:pool",
        "//closure/library/style",
        "//closure/library/timer",
    ],
)

closure_js_library(
    name = "imagelessbuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/imagelessbuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:button",
        "//closure/library/ui:component",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:custombuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "imagelessmenubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/imagelessmenubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menubuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "inputdatepicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/inputdatepicker.js"],
    lenient = True,
    deps = [
        "//closure/library/date",
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/i18n:datetimeparse",
        "//closure/library/string",
        "//closure/library/ui:component",
        "//closure/library/ui:datepicker",
        "//closure/library/ui:labelinput",
        "//closure/library/ui:popupbase",
        "//closure/library/ui:popupdatepicker",
    ],
)

closure_js_library(
    name = "itemevent",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/itemevent.js"],
    lenient = True,
    deps = ["//closure/library/events:event"],
)

closure_js_library(
    name = "keyboardshortcuthandler",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/keyboardshortcuthandler.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keynames",
        "//closure/library/events:keys",
        "//closure/library/object",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "labelinput",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/labelinput.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "linkbuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/linkbuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:button",
        "//closure/library/ui:flatbuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "menu",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menu.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/math:coordinate",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:container",
        "//closure/library/ui:menuheader",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:menurenderer",
        "//closure/library/ui:menuseparator",
    ],
)

closure_js_library(
    name = "menubar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubar.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:container",
        "//closure/library/ui:menubarrenderer",
    ],
)

closure_js_library(
    name = "menubardecorator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubardecorator.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:menubar",
        "//closure/library/ui:menubarrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "menubarrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubarrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/ui:container",
        "//closure/library/ui:containerrenderer",
    ],
)

closure_js_library(
    name = "menubase",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubase.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keyhandler",
        "//closure/library/ui:popup",
    ],
)

closure_js_library(
    name = "menubutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubutton.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/math:box",
        "//closure/library/math:rect",
        "//closure/library/positioning",
        "//closure/library/positioning:menuanchoredposition",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:button",
        "//closure/library/ui:component",
        "//closure/library/ui:idgenerator",
        "//closure/library/ui:menu",
        "//closure/library/ui:menubuttonrenderer",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:menurenderer",
        "//closure/library/ui:registry",
        "//closure/library/useragent",
        "//closure/library/useragent:product",
    ],
)

closure_js_library(
    name = "menubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:custombuttonrenderer",
        "//closure/library/ui:menu",
        "//closure/library/ui:menurenderer",
    ],
)

closure_js_library(
    name = "menuheader",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuheader.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:menuheaderrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "menuheaderrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuheaderrenderer.js"],
    lenient = True,
    deps = ["//closure/library/ui:controlrenderer"],
)

closure_js_library(
    name = "menuitem",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuitem.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/math:coordinate",
        "//closure/library/string",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:menuitemrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "menuitemrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuitemrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:component",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "menurenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menurenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:containerrenderer",
        "//closure/library/ui:separator",
    ],
)

closure_js_library(
    name = "menuseparator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuseparator.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:menuseparatorrenderer",
        "//closure/library/ui:registry",
        "//closure/library/ui:separator",
    ],
)

closure_js_library(
    name = "menuseparatorrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/menuseparatorrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "mockactivitymonitor",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/mockactivitymonitor.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtype",
        "//closure/library/ui:activitymonitor",
    ],
)

closure_js_library(
    name = "modalariavisibilityhelper",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/modalariavisibilityhelper.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
    ],
)

closure_js_library(
    name = "modalpopup",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/modalpopup.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:iframe",
        "//closure/library/dom:tagname",
        "//closure/library/dom/animationframe",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:focushandler",
        "//closure/library/fx:transition",
        "//closure/library/string",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:modalariavisibilityhelper",
        "//closure/library/ui:popupbase",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "nativebuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/nativebuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/ui:buttonrenderer",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "option",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/option.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:component",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "palette",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/palette.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/math:size",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:paletterenderer",
        "//closure/library/ui:selectionmodel",
    ],
)

closure_js_library(
    name = "paletterenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/paletterenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:nodeiterator",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:tagname",
        "//closure/library/iter",
        "//closure/library/style",
        "//closure/library/ui:controlrenderer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "plaintextspellchecker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/plaintextspellchecker.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/spell:spellcheck",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:abstractspellchecker",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "popup",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/popup.js"],
    lenient = True,
    deps = [
        "//closure/library/math:box",
        "//closure/library/positioning",
        "//closure/library/positioning:abstractposition",
        "//closure/library/style",
        "//closure/library/ui:popupbase",
    ],
)

closure_js_library(
    name = "popupbase",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/popupbase.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/fx:transition",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "popupcolorpicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/popupcolorpicker.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/events:eventtype",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredposition",
        "//closure/library/ui:colorpicker",
        "//closure/library/ui:component",
        "//closure/library/ui:popup",
    ],
)

closure_js_library(
    name = "popupdatepicker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/popupdatepicker.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtype",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredposition",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:datepicker",
        "//closure/library/ui:popup",
        "//closure/library/ui:popupbase",
    ],
)

closure_js_library(
    name = "popupmenu",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/popupmenu.js"],
    lenient = True,
    deps = [
        "//closure/library/events",
        "//closure/library/events:browserevent",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredviewportposition",
        "//closure/library/positioning:menuanchoredposition",
        "//closure/library/positioning:viewportclientposition",
        "//closure/library/structs:map",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:menu",
        "//closure/library/ui:popupbase",
    ],
)

closure_js_library(
    name = "progressbar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/progressbar.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/ui:component",
        "//closure/library/ui:rangemodel",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "prompt",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/prompt.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/functions",
        "//closure/library/html:safehtml",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:dialog",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "rangemodel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/rangemodel.js"],
    lenient = True,
    deps = [
        "//closure/library/events:eventtarget",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "ratings",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/ratings.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "registry",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/registry.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
    ],
)

closure_js_library(
    name = "richtextspellchecker",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/richtextspellchecker.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:nodetype",
        "//closure/library/dom:range",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/math:coordinate",
        "//closure/library/spell:spellcheck",
        "//closure/library/string:stringbuffer",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:abstractspellchecker",
        "//closure/library/ui:component",
        "//closure/library/ui:popupmenu",
    ],
)

closure_js_library(
    name = "roundedpanel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/roundedpanel.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/graphics",
        "//closure/library/graphics:path",
        "//closure/library/graphics:solidfill",
        "//closure/library/graphics:stroke",
        "//closure/library/math",
        "//closure/library/math:coordinate",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "roundedtabrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/roundedtabrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:registry",
        "//closure/library/ui:tab",
        "//closure/library/ui:tabbar",
        "//closure/library/ui:tabrenderer",
    ],
)

closure_js_library(
    name = "scrollfloater",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/scrollfloater.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "select",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/select.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/events:eventtype",
        "//closure/library/ui:component",
        "//closure/library/ui:idgenerator",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:menurenderer",
        "//closure/library/ui:registry",
        "//closure/library/ui:selectionmodel",
    ],
)

closure_js_library(
    name = "selectionmenubutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/selectionmenubutton.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:inputtype",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/ui:menubutton",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "selectionmodel",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/selectionmodel.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
    ],
)

closure_js_library(
    name = "separator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/separator.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/asserts",
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:menuseparatorrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "serverchart",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/serverchart.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events:event",
        "//closure/library/string",
        "//closure/library/ui:component",
        "//closure/library/uri",
    ],
)

closure_js_library(
    name = "slider",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/slider.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:sliderbase",
    ],
)

closure_js_library(
    name = "sliderbase",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/sliderbase.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/events:mousewheelhandler",
        "//closure/library/functions",
        "//closure/library/fx:animationqueue",
        "//closure/library/fx:dom",
        "//closure/library/fx:dragger",
        "//closure/library/fx:transition",
        "//closure/library/math",
        "//closure/library/math:coordinate",
        "//closure/library/style",
        "//closure/library/style:bidi",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:rangemodel",
    ],
)

closure_js_library(
    name = "splitpane",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/splitpane.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/fx:dragger",
        "//closure/library/math:rect",
        "//closure/library/math:size",
        "//closure/library/style",
        "//closure/library/ui:component",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "submenu",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/submenu.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events:keycodes",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredviewportposition",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:component",
        "//closure/library/ui:menu",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
        "//closure/library/ui:submenurenderer",
    ],
)

closure_js_library(
    name = "submenurenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/submenurenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/style",
        "//closure/library/ui:menu",
        "//closure/library/ui:menuitemrenderer",
    ],
)

closure_js_library(
    name = "tab",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tab.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:component",
        "//closure/library/ui:control",
        "//closure/library/ui:registry",
        "//closure/library/ui:tabrenderer",
    ],
)

closure_js_library(
    name = "tabbar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tabbar.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:component",
        "//closure/library/ui:container",
        "//closure/library/ui:registry",
        "//closure/library/ui:tab",
        "//closure/library/ui:tabbarrenderer",
    ],
)

closure_js_library(
    name = "tabbarrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tabbarrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/object",
        "//closure/library/ui:containerrenderer",
    ],
)

closure_js_library(
    name = "tablesorter",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tablesorter.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events:eventtype",
        "//closure/library/functions",
        "//closure/library/ui:component",
    ],
)

closure_js_library(
    name = "tabpane",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tabpane.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:event",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/html:safestylesheet",
        "//closure/library/style",
    ],
)

closure_js_library(
    name = "tabrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tabrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/ui:component",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "textarea",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/textarea.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events:eventtype",
        "//closure/library/style",
        "//closure/library/ui:control",
        "//closure/library/ui:textarearenderer",
        "//closure/library/useragent",
    ],
)

closure_js_library(
    name = "textarearenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/textarearenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:tagname",
        "//closure/library/ui:component",
        "//closure/library/ui:controlrenderer",
    ],
)

closure_js_library(
    name = "togglebutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/togglebutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:button",
        "//closure/library/ui:component",
        "//closure/library/ui:custombuttonrenderer",
        "//closure/library/ui:registry",
    ],
)

closure_js_library(
    name = "toolbar",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbar.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:container",
        "//closure/library/ui:toolbarrenderer",
    ],
)

closure_js_library(
    name = "toolbarbutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarbutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:button",
        "//closure/library/ui:registry",
        "//closure/library/ui:toolbarbuttonrenderer",
    ],
)

closure_js_library(
    name = "toolbarbuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarbuttonrenderer.js"],
    lenient = True,
    deps = ["//closure/library/ui:custombuttonrenderer"],
)

closure_js_library(
    name = "toolbarcolormenubutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarcolormenubutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:colormenubutton",
        "//closure/library/ui:registry",
        "//closure/library/ui:toolbarcolormenubuttonrenderer",
    ],
)

closure_js_library(
    name = "toolbarcolormenubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarcolormenubuttonrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/ui:colormenubuttonrenderer",
        "//closure/library/ui:menubuttonrenderer",
        "//closure/library/ui:toolbarmenubuttonrenderer",
    ],
)

closure_js_library(
    name = "toolbarmenubutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarmenubutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:menubutton",
        "//closure/library/ui:registry",
        "//closure/library/ui:toolbarmenubuttonrenderer",
    ],
)

closure_js_library(
    name = "toolbarmenubuttonrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarmenubuttonrenderer.js"],
    lenient = True,
    deps = ["//closure/library/ui:menubuttonrenderer"],
)

closure_js_library(
    name = "toolbarrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom:tagname",
        "//closure/library/ui:container",
        "//closure/library/ui:containerrenderer",
        "//closure/library/ui:separator",
        "//closure/library/ui:toolbarseparatorrenderer",
    ],
)

closure_js_library(
    name = "toolbarselect",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarselect.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:registry",
        "//closure/library/ui:select",
        "//closure/library/ui:toolbarmenubuttonrenderer",
    ],
)

closure_js_library(
    name = "toolbarseparator",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarseparator.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:registry",
        "//closure/library/ui:separator",
        "//closure/library/ui:toolbarseparatorrenderer",
    ],
)

closure_js_library(
    name = "toolbarseparatorrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbarseparatorrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/dom:tagname",
        "//closure/library/ui:cssnames",
        "//closure/library/ui:menuseparatorrenderer",
    ],
)

closure_js_library(
    name = "toolbartogglebutton",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/toolbartogglebutton.js"],
    lenient = True,
    deps = [
        "//closure/library/ui:registry",
        "//closure/library/ui:togglebutton",
        "//closure/library/ui:toolbarbuttonrenderer",
    ],
)

closure_js_library(
    name = "tooltip",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tooltip.js"],
    lenient = True,
    deps = [
        "//closure/library/array",
        "//closure/library/asserts",
        "//closure/library/dom",
        "//closure/library/dom:safe",
        "//closure/library/dom:tagname",
        "//closure/library/events",
        "//closure/library/events:eventtype",
        "//closure/library/events:focushandler",
        "//closure/library/math:box",
        "//closure/library/math:coordinate",
        "//closure/library/positioning",
        "//closure/library/positioning:anchoredposition",
        "//closure/library/positioning:viewportposition",
        "//closure/library/structs:set",
        "//closure/library/style",
        "//closure/library/timer",
        "//closure/library/ui:popup",
        "//closure/library/ui:popupbase",
    ],
)

closure_js_library(
    name = "tristatemenuitem",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tristatemenuitem.js"],
    lenient = True,
    deps = [
        "//closure/library/dom:classlist",
        "//closure/library/ui:component",
        "//closure/library/ui:menuitem",
        "//closure/library/ui:registry",
        "//closure/library/ui:tristatemenuitemrenderer",
    ],
)

closure_js_library(
    name = "tristatemenuitemrenderer",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/tristatemenuitemrenderer.js"],
    lenient = True,
    deps = [
        "//closure/library/asserts",
        "//closure/library/dom:classlist",
        "//closure/library/ui:menuitemrenderer",
    ],
)

closure_js_library(
    name = "twothumbslider",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/twothumbslider.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom",
        "//closure/library/dom:tagname",
        "//closure/library/ui:sliderbase",
    ],
)

closure_js_library(
    name = "zippy",
    srcs = ["@com_google_javascript_closure_library//:closure/goog/ui/zippy.js"],
    lenient = True,
    deps = [
        "//closure/library/a11y/aria",
        "//closure/library/a11y/aria:attributes",
        "//closure/library/a11y/aria:roles",
        "//closure/library/dom",
        "//closure/library/dom:classlist",
        "//closure/library/events:event",
        "//closure/library/events:eventhandler",
        "//closure/library/events:eventtarget",
        "//closure/library/events:eventtype",
        "//closure/library/events:keycodes",
        "//closure/library/events:keyhandler",
        "//closure/library/style",
    ],
)
