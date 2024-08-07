# Reads all result-*.json files in the current directory
# (generated by the weekly_tests workflow),
# and prints a markdown formatted summary
# suitable for sending to the team mattermost channel.

import sys
import glob
import json


def load_results() -> list[dict[str, str]]:
    """Return a list of result data from all result-*.json files"""
    results = []
    for path in glob.glob("result-*.json"):
        with open(path) as f:
            results.append(json.load(f))
    return results


def format_result(result: dict[str, str]) -> str:
    """Take a result and return a markdown string"""
    icon = (
        ":gh-success-octicon-checkcirclefillicon:"
        if result["conclusion"] == "success"
        else ":gh-failure-octicon-xcirclefillicon:"
    )
    repo = result["repo"]
    branch = result["branch"]
    workflow = result["workflow_file_name"]
    url = result["workflow_url"]
    return f"- [{repo} ({branch}, {workflow})]({url}) {icon}"


def summarise(results: list[dict[str, str]], action_url: str) -> str:
    """Take the results and a link to the github action run and return a markdown summary"""
    failed = len([result for result in results if result["conclusion"] != "success"])
    total = len(results)

    if failed == 0:
        return f":robot_face: all [weekly tests]({action_url}) passed! :tada:"
    else:
        return f":robot_face: @soleng {failed}/{total} [weekly tests]({action_url}) failed:"


def print_results(results: list[dict[str, str]], action_url: str):
    """Take the results and a link to the github action run and print a markdown formatted message"""
    print(summarise(results, action_url))
    for result in results:
        print(format_result(result))


if __name__ == "__main__":
    if len(sys.argv) > 1:
        github_action_url = sys.argv[1]
    else:
        print("Usage: summarise-results.py <github-action-url>")
        sys.exit(1)

    results = load_results()
    print_results(results, github_action_url)
