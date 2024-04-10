# solutions-engineering-automation
Repo for automating tasks for Solutions Engineering Team.


## How it works

The weekly_tests workflow lists all repos on GitHub maintained by the Solutions Engineering Team, and the job for dispatching test on top of those repos remotely.
The configuration description:
 - `repo` is the name of a repository in canonical organization, e.g. charm-apt-mirror
 - `workflow_file_name` is name of workflow file which should be triggered, e.g. check.yaml
 - `branch` name of branch from which tests should be executed, e.g. main

All jobs are run in parallel with the maximum number of concurency defined by the `max-parallel` strategy parameter,
we can to control how many jobs can be run simultaneously using this parameter.
This is important for us, since we don't want to allow all jobs to run at the same time, because some of them are
running on top of self-hosted runners, and we can hit quota limits.

The result of each run is collected and sent via MM bot to our channel as notifications.
