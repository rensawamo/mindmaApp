#/bin/bash
echo $DART_DEFINE | tr ',' '\n' | while read line; 
do
  echo $line | base64 -d | tr ',' '\n' | xargs -I@ bash -c "echo @ | grep 'FLAVOR' | sed 's/.*=//'"
  echo $flavor
done | (
  read flavor
  echo "#include \"prd.xcconfig\"" > $SRCROOT/Flutter/DartDefine.xcconfig
)
