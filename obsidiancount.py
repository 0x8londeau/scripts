# count the total number of words for obsidian notes dir
# update file_path with local directory 
import os

def count_words_in_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
            return len(content.split())
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return 0

def main(vault_path):
    total_notes = 0
    total_words = 0

    print(f"Starting scan of vault at: {vault_path}")

    for root, dirs, files in os.walk(vault_path):
        print(f"Scanning directory: {root}")
        for file in files:
            if file.endswith('.md'):
                file_path = os.path.join(root, file)
                print(f"Found Markdown file: {file_path}")
                total_notes += 1
                words_in_file = count_words_in_file(file_path)
                total_words += words_in_file
                print(f"Processed {file_path}: {words_in_file} words")

    print(f"Total Notes: {total_notes}")
    print(f"Total Words: {total_words}")

if __name__ == "__main__":
    # Change vault_path " " to reflect local Obsidian Vault dir
    vault_path = "/dir_path/Obsidian Vault"  # Adjust this path
    print(f"Scanning vault at: {vault_path}")
    main(vault_path)
