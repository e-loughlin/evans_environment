import fnmatch
import os


def confirm_action(warning_message):
    while True:
        choice = input(f"{warning_message} (Y/n): ").strip().lower()
        if choice.startswith("y"):
            return True
        if choice.startswith("n"):
            return False
        print("Invalid choice. Please enter Y or n.")


def combine_files(pattern="*.py", output_file="combined.txt"):
    files_to_process = []

    # 1. Recursively find files
    for root, dirs, files in os.walk("."):
        # Prevent searching in common massive hidden folders to save time
        if ".git" in dirs:
            dirs.remove(".git")

        for filename in fnmatch.filter(files, pattern):
            if filename == output_file:
                continue
            files_to_process.append(os.path.join(root, filename))

    if not files_to_process:
        print(f"No files found matching '{pattern}'.")
        return

    # 2. Warn and Confirm
    msg = (
        f"This will combine {len(files_to_process)} files into {output_file}. Proceed?"
    )
    if not confirm_action(msg):
        print("Operation cancelled.")
        return

    # 3. Combine
    try:
        with open(output_file, "w", encoding="utf-8") as outfile:
            for filepath in files_to_process:
                outfile.write(f"\n--- FILE: {filepath} ---\n")
                try:
                    with open(
                        filepath, "r", encoding="utf-8", errors="ignore"
                    ) as infile:
                        outfile.write(infile.read())
                    outfile.write("\n")
                except Exception as e:
                    outfile.write(f"[Error reading file: {e}]\n")

        print(f"Successfully combined {len(files_to_process)} files into {output_file}")
    except PermissionError:
        print(f"Error: Could not write to {output_file}. Check permissions.")


if __name__ == "__main__":
    combine_files()
