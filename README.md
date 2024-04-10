# solutions-engineering-automation
Repo for automating tasks for Solutions Engineering Team.


## How it works

The weekly_tests workflow lists all repos on GitHub maintained by the Solutions Engineering Team, and the job for dispatching test on top of those repos remotely.
The configuration description:
 - `repo` is the name of a repository in canonical organization, e.g. charm-apt-mirror
 - `workflow_file_name` is name of workflow file which should be triggered, e.g. check.yaml
 - `branch` name of branch from which tests should be executed, e.g. main

Jobs are running in parallel with the maximum number of concurrency defined by the `max-parallel` strategy parameter,
we can control how many jobs can be run simultaneously using this parameter.
This is important for us because we don't want to allow all jobs to run simultaneously. Some of them are
running on top of self-hosted runners, and we could hit quota limits.

The results of each run are collected, aggregated, and then sent via MM bot to our channel as notifications.
