#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

rm -rf $1/preinstall
rm -rf $1/product/app/Chrome
rm -rf $1/product/app/Drive
rm -rf $1/product/app/Duo
rm -rf $1/product/app/Gmail2
rm -rf $1/product/app/GoogleWallpapers
rm -rf $1/product/app/Maps
rm -rf $1/product/app/Messages
rm -rf $1/product/app/Photos
rm -rf $1/product/app/talkback
rm -rf $1/product/app/Videos
rm -rf $1/product/app/YouTube
rm -rf $1/product/priv-app/AndroidAutoStub
rm -rf $1/product/priv-app/EmergencyInfo
rm -rf $1/product/priv-app/GoogleFeedback
rm -rf $1/app/BookmarkProvider
rm -rf $1/app/PrintSpooler
rm -rf $1/app/WallpaperBackup
rm -rf $1/app/YTMusic
rm -rf $1/app/ZuiThirdPartySdk
rm -rf $1/priv-app/ZuiXlog
rm -rf $1/priv-app/ZuiCamera
rm -rf $1/priv-app/AppDaily
rm -rf $1/priv-app/ZuiXlog
rm -rf $1/priv-app/ZuiSystemUpgrade
rm -rf $1/priv-app/ZuiLegalInfo
rm -rf $1/priv-app/ZuiGameHelper
rm -rf $1/priv-app/ZuiDolphin
rm -rf $1/priv-app/ZuiCamera
rm -rf $1/priv-app/VpnDialogs
