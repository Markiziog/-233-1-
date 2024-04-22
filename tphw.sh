if [ "$#" -ne 2 ]; then
    echo "Используется: $0 входная_директория выходная_директория"
    exit 1
fi

input_dir="$1"
output_dir="$2"
mkdir -p "$output_dir"
files=$(find "$input_dir" -maxdepth 1 -type f)
dirs=$(find "$input_dir" -maxdepth 1 -type d)
echo "Файлы на первом уровне входной директории:"
echo "$files"
echo "Директории на первом уровне входной директории:"
echo "$dirs"
all_files=$(find "$input_dir" -type f)


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
echo "Скопировано в $output_dir"









