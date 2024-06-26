# -233-ТЗ1-Гребенщиков
Вот подробное объяснение моего Bash скрипта, который копирует файлы из одной директории в другую, учитывая возможные конфликты имен файлов:

### Проверка аргументов:
```bash
if [ "$#" -ne 2 ]; then
    echo "Используется: $0 входная_директория выходная_директория"
    exit 1
fi
```
Эта проверка гарантирует, что скрипт запущен с корректным количеством аргументов — входной и выходной директориями. Если нет то, скрипт завершает выполнение с кодом ошибки 1.

### Определение директорий:
```bash
input_dir="$1"  # первый аргумент  input_dir
output_dir="$2" # второй аргумент  output_dir
```
Здесь я сохраняю пути входной и выходной директорий в соответствующие переменные для дальнейшего использования.

### Создание выходной директории:
```bash
mkdir -p "$output_dir"
```
### Получение списка файлов и директорий:
```bash
files=$(find "$input_dir" -maxdepth 1 -type f)
dirs=$(find "$input_dir" -maxdepth 1 -type d)
echo "Файлы на первом уровне входной директории:"
echo "$files"
echo "Директории на первом уровне входной директории:"
echo "$dirs"
all_files=$(find "$input_dir" -type f)
```
Эти команды получают список файлов и директорий только первого уровня входной директории и выводят их. 

### Копирование файлов:
```bash
while IFS= read -r file; do
    base_name=$(basename "$file")
    counter=0
    output_file="$output_dir/$base_name"
    while [ -e "$output_file" ]; do
        counter=$((counter + 1))
        output_file="$output_dir/${base_name}_$counter"
    done
    cp "$file" "$output_file"
done <<< "$all_files"
```
В этом цикле я обрабатываю каждый файл из списка `all_files`. Проверяю наличие файла с таким же именем в выходной директории и, в случае конфликта, добавляю к имени файла счётчик, пока имя файла не станет уникальным, чтоьы избежать проблемы, которые описаны в условии тз

### Вывод:
```bash
echo "Скопировано в $output_dir"
```
В конце скрипта я выводу сообщение о том, что все файлы успешно скопированы в указанную выходную директорию. 

