for i in {10..23..1}
do
sed 's#user_group_ref=\"Journal manager\"##g' $i.xml > ${i}_p.xml
done

