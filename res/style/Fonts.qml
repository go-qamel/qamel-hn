pragma Singleton

import QtQuick 2.11

Item {
    FontLoader {
        id: fontAwesomeRegular
        source: "../assets/Font Awesome 5 Free-Regular-400.otf"
    }

    FontLoader {
        id: fontAwesomeSolid
        source: "../assets/Font Awesome 5 Free-Solid-900.otf"
    }

    FontLoader {
        id: fontAwesomeBrands
        source: "../assets/Font Awesome 5 Brands-Regular-400.otf"
    }

    FontLoader {
        id: sourceSansProRegular
        source: "../assets/Source Sans Pro-Regular.ttf"
    }

    FontLoader {
        id: sourceSansPro600
        source: "../assets/Source Sans Pro-600.ttf"
    }

    FontLoader {
        id: sourceSansPro700
        source: "../assets/Source Sans Pro-700.ttf"
    }

    readonly property string fontAwesomeIcons: fontAwesomeRegular.name
    readonly property string fontAwesomeBrands: fontAwesomeBrands.name
    readonly property string sourceSansPro: sourceSansProRegular.name
    readonly property string sourceSansProSemiBold: sourceSansPro600.name
}