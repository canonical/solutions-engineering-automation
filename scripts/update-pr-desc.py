#!/usr/bin/env python3

"""The script updates the provided PR's description with the commit."""

import argparse
import logging
import os
import re
from typing import Optional

import requests

OWNER = "canonical"
SOURCE_REPO = "solutions-engineering-automation"
DEFAULT_BODY = (
    "This is an automated pull request from "
    "https://github.com/canonical/solutions-engineering-automation "
    "to update centrally managed files."
)
CHANGELOG_HEADER = "### Changelog"

logger = logging.getLogger("update-pr-desc")
logging.basicConfig(level=logging.INFO)


def get_pr_body(repo: str, pr_number: int, token: str) -> Optional[str]:
    """Get the PR's information from the Github API."""
    resp = requests.get(
        f"https://api.github.com/repos/{OWNER}/{repo}/pulls/{pr_number}",
        headers={
            "Authorization": f"Bearer {token}",
        },
    )

    resp.raise_for_status()
    return resp.json().get("body", None)


def update_pr_body(repo: str, pr_number: int, token: str, body: str) -> None:
    """Update the PR's body with the new description."""
    resp = requests.patch(
        f"https://api.github.com/repos/{OWNER}/{repo}/pulls/{pr_number}",
        headers={
            "Authorization": f"Bearer {token}",
        },
        json={"body": body},
    )

    resp.raise_for_status()


def get_commit_pr_url(commit: str, token: str) -> Optional[str]:
    """Get the Commit's information from the Github API."""
    resp = requests.get(
        f"https://api.github.com/repos/{OWNER}/{SOURCE_REPO}/commits/{commit}/pulls",
        headers={
            "Authorization": f"Bearer {token}",
        },
    )

    resp.raise_for_status()

    result = resp.json()
    if not result:
        raise ValueError("No PRs associated with this commit")
    if len(result) > 1:
        logger.warning("Multiple PRs found for commit. Using the first one.")

    return result[0].get("html_url", None)


def parse_pr_url(url: str) -> tuple:
    """Parse the PR URL and return the repo and PR number."""
    escaped_owner = re.escape(OWNER)
    regex = re.compile(rf"github\.com\/{escaped_owner}\/([a-zA-Z-]+)\/pull\/(\d+)")
    result = regex.search(url)

    if not result or len(result.groups()) != 2:
        raise ValueError("Invalid PR URL")

    return result.groups()


def create_new_description(body: Optional[str], commit_url: str, append: bool):
    """Create a new description for the PR."""
    if not body:
        logger.warning("No description found. Creating a new one.")
        body = DEFAULT_BODY
        append = False

    if commit_url in body:
        logger.warning("Commit already in the PR's description")
        return body

    changelog_header = ""
    if not append and CHANGELOG_HEADER not in body:
        changelog_header = f"\n\n{CHANGELOG_HEADER}\n"
    new_body = f"{body.rstrip()}{changelog_header}\n- {commit_url}"

    return new_body


def update_description(url: str, sha: str, token: str, append: bool = False):
    """Update the PR's description with the commit URL."""
    try:
        repo, pr_number = parse_pr_url(url)
        pr_body = get_pr_body(repo, pr_number, token)
        commit_pr_url = get_commit_pr_url(sha, token)
        if not commit_pr_url:
            raise ValueError("No PR URL found for the commit")

        new_desc = create_new_description(pr_body, commit_pr_url, append)
        logger.info("New description:\n%s", new_desc)

        update_pr_body(repo, pr_number, token, new_desc)
        logger.info("Updated the PR's description successfully")
    except Exception as e:
        logger.error("Failed to update the description: %s", e)
        exit(1)

def main():
    """Run the script."""
    parser = argparse.ArgumentParser(
        prog="Update PR description",
        description="Updates the provided PR's description with the commit",
    )
    parser.add_argument("--url", required=True, help="URL of the PR to be updated")
    parser.add_argument(
        "--commit",
        required=True,
        help="The Commit SHA which will be included in the PR's description",
    )
    parser.add_argument(
        "-a",
        "--append",
        default=False,
        help="Whether to append to the existing list of commits or create it",
        action="store_true",
    )

    args = parser.parse_args()
    token = os.getenv("GITHUB_TOKEN")

    if not token:
        parser.error(
            "Github token is required. Provide it by setting the GITHUB_TOKEN environment variable."
        )

    update_description(args.url, args.commit, token, args.append)


if __name__ == "__main__":
    main()
