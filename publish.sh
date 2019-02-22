#!/bin/bash

# arrProjs=("./doc/WalkingTec.Mvvm.Doc/WalkingTec.Mvvm.Doc" "./demo/WalkingTec.Mvvm.ApiDemo/WalkingTec.Mvvm.ApiDemo" "./demo/WalkingTec.Mvvm.Demo/WalkingTec.Mvvm.Demo")
arrProjs=("WalkingTec.Mvvm.ApiDemo" "WalkingTec.Mvvm.Demo")
configuration="Release"
# win-x64 linux-x64
# https://docs.microsoft.com/zh-cn/dotnet/core/rid-catalog#linux-rids
runtime="win-x64"
framework="netcoreapp2.2"
outputRoot="./publish"
selfContained="true"

# 清理 publish 目录
echo "开始清理 publish 目录"
rm -rfv $outputRoot
echo "publish 目录清理完成"

# 开始发布
echo "开始发布"
for proj in ${arrProjs[@]}
do
projPath="./demo/$proj/$proj"
outputDir="$outputRoot/$proj"
echo "发布 $proj"
publishCMD="\"$projPath.csproj\" -c $configuration -r $runtime -f $framework --self-contained $selfContained -o \"$outputDir\""
dotnet publish $publishCMD
echo "$proj 发布完成"
done
echo "全部发布完成"

# 打包
echo "开始打包"
cd $outputRoot
for proj in ${arrProjs[@]}
do
zipName="$proj.zip"
zip -q -r $zipName $proj
done
echo "全部打包完成"