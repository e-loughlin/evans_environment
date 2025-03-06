import subprocess
import re
import argparse
from datetime import datetime


def get_git_commits_since(base_sha):
    log_cmd = ["git", "rev-list", "HEAD", "^" + base_sha]
    result = subprocess.run(log_cmd, capture_output=True, text=True)
    commits = result.stdout.strip().split("\n")
    return commits[::-1]  # Process from oldest to newest


def get_git_diff(base_sha, folder):
    diff_cmd = ["git", "diff", base_sha, "HEAD", "--", folder]
    result = subprocess.run(diff_cmd, capture_output=True, text=True)
    return result.stdout


def get_commit_diff(commit, folder):
    diff_cmd = ["git", "diff", commit + "^", commit, "--", folder]
    result = subprocess.run(diff_cmd, capture_output=True, text=True)
    return result.stdout


def get_commit_info(commit):
    log_cmd = ["git", "log", "-1", "--format=%H%n%ad%n%s", commit]
    result = subprocess.run(log_cmd, capture_output=True, text=True)
    sha, date, message = result.stdout.strip().split("\n", 2)
    return sha, date, message


def extract_relevant_changes(diff_text, grep_string):
    relevant_changes = {}
    file_name = None

    for line in diff_text.splitlines():
        if line.startswith("diff --git"):
            file_name = line.split(" ")[-1]  # Extract file name

        if line.startswith("+") and re.search(rf"\b({grep_string})\b", line):
            if file_name:
                if file_name not in relevant_changes:
                    relevant_changes[file_name] = set()
                relevant_changes[file_name].add(line.strip())  # Normalize line

    return relevant_changes


def generate_markdown(commit_data):
    md = []

    for sha, date, message, changes in commit_data:
        md.append("# Commit " + sha[:8])
        md.append(f"**Date:** {date}")
        md.append(f"**Message:** {message}")
        md.append("\n---\n")

        for file, diffs in changes.items():
            md.append(f"## {file}")
            md.append("```cpp")
            md.extend(diffs)
            md.append("```")
            md.append("\n---\n")

    return "\n".join(md)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Extract git diff per commit with specific keywords and generate a markdown report."
    )
    parser.add_argument("--base_sha", help="The base SHA to compare against HEAD")
    parser.add_argument("--folder", help="The folder to scan for diffs")
    parser.add_argument(
        "--grep_string",
        help="The keywords to filter in the diff, e.g., 'XXX|TODO|DEPRECATED'",
    )
    parser.add_argument(
        "--output",
        default="git_diff_report.md",
        help="Output filename for the markdown report",
    )
    args = parser.parse_args()

    overall_diff = extract_relevant_changes(
        get_git_diff(args.base_sha, args.folder), args.grep_string
    )
    commits = get_git_commits_since(args.base_sha)
    commit_data = []

    for commit in commits:
        diff_text = get_commit_diff(commit, args.folder)
        changes = extract_relevant_changes(diff_text, args.grep_string)

        filtered_changes = {
            file: {
                line
                for line in diffs
                if file in overall_diff and line in overall_diff[file]
            }
            for file, diffs in changes.items()
        }
        filtered_changes = {
            file: diffs for file, diffs in filtered_changes.items() if diffs
        }

        if filtered_changes:
            sha, date, message = get_commit_info(commit)
            commit_data.append((sha, date, message, filtered_changes))

    if commit_data:
        markdown_report = generate_markdown(commit_data)
        with open(args.output, "w") as f:
            f.write(markdown_report)
        print(f"Markdown report saved as {args.output}")
    else:
        print("No relevant changes found.")
