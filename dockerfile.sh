# Список файлов Dockerfile, для которых нужно выполнить сборку
dockerfiles=($ls Dockerfile_*)

# Проходим по каждому Dockerfile в списке
for dockerfile in "${dockerfiles[@]}"; do
# Проверяем наличие Dockerfile
TYPE=$(echo $dockerfile | awk -F '_' '{print $2}')
if [ -f "$dockerfile" ]; then
#Если файл существует, выполняем сборку
echo docker build -f "$dockerfile" --pull --build-arg REVISION=$TAG ${EXTRA_BUILD_VARS} --cache-from $NEXUS_LINK/$CI_PROJECT_NAMESPACE $NEXUS_TEST_IMAGES/$CI_PROJECT_NAME -t $NEXUS_LINK/$CI_PROJECT_NAMESPACE/$>
else
# Если файла нет, выводим сообщение об пропуске этапа сборки
echo "Skipping $dockerfile build stage."; fi
done
