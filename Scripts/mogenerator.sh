
echo "Удаление старых MogeneratorPONSO"
cd "${SRCROOT}/conferences/Classes/Models/GeneratedPONSO/"
rm *.*
echo " "

echo "Переименование ponso c нашей логикой для того что бы их не перегенерировал mogenerator"
cd "${SRCROOT}/conferences/Classes/Models/PlainObjects/"
for file in *.*
do
filename="${file/PlainObject/}"
mv $file ${filename}
done
echo " "

echo "Удаление старых Mogenerator ManagedObject"
cd "${SRCROOT}/conferences/Classes/Models/GeneratedMO/"
rm *.*
echo " "

echo "Переименование ponso c нашей логикой для того что бы их не перегенерировал mogenerator"
cd "${SRCROOT}/conferences/Classes/Models/ManagedObjects/"
for file in *.*
do
filename="${file/ModelObject/}"
mv $file ${filename}
done
echo " "

echo "Запуск скрипта mogenerator"
/usr/local/bin/mogenerator \
--model "${PROJECT_DIR}/conferences/Classes/Models/CoreDataModel/Conference.xcdatamodeld" \
--machine-dir "${PROJECT_DIR}/conferences/Classes/Models/GeneratedMO/" \
--human-dir "${PROJECT_DIR}/conferences/Classes/Models/ManagedObjects/" \
--template-path "${PROJECT_DIR}/Scripts/MOTemplates" \
--template-var arc=true

echo "Generating PONSO"

/usr/local/bin/mogenerator \
--model "${PROJECT_DIR}/conferences/Classes/Models/CoreDataModel/Conference.xcdatamodeld" \
--machine-dir "${PROJECT_DIR}/conferences/Classes/Models/GeneratedPONSO/" \
--human-dir "${PROJECT_DIR}/conferences/Classes/Models/PlainObjects/" \
--template-path "${PROJECT_DIR}/Scripts/PONSOTemplates" \
--base-class "NSObject" \
--template-var arc=true
echo " "

echo "Переименование ponso c нашей логикой обратно"
cd "${SRCROOT}/conferences/Classes/Models/GeneratedPONSO/"
for file in *.*
do
filename="${file%.*}"
ext="${file##*.}"
mv $file ${filename}PlainObject.${ext}
done
echo " "

cd "${SRCROOT}/conferences/Classes/Models/PlainObjects/"
for file in *.*
do
filename="${file%.*}"
ext="${file##*.}"
mv $file ${filename}PlainObject.${ext}
done

echo "Переименование ponso c нашей логикой обратно"
cd "${SRCROOT}/conferences/Classes/Models/GeneratedMO/"
for file in *.*
do
filename="${file%.*}"
ext="${file##*.}"
mv $file ${filename}ModelObject.${ext}
done
echo " "

cd "${SRCROOT}/conferences/Classes/Models/ManagedObjects/"
for file in *.*
do
filename="${file%.*}"
ext="${file##*.}"
mv $file ${filename}ModelObject.${ext}
done