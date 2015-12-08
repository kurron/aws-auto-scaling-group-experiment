#!/bin/bash

# Right now, we cannot create a scheduled scaling policy via Terraform.
# We have to drop down to the AWS CLI.

#To schedule scaling on a recurring schedule

# You can specify a recurrence schedule using the Unix cron syntax format. 
# For more information about cron syntax, see the Cron Wikipedia entry.

# Use the following put-scheduled-update-group-action command to create a scheduled action 
# named scaleup-schedule-year that runs at 00:30 hours on the first of January, June, and December each year:
#
# aws autoscaling put-scheduled-update-group-action --scheduled-action-name scaleup-schedule-year --auto-scaling-group-name my-asg --recurrence "30 0 1 1,6,12 0" --desired-capacity 3

# Cron format
# ┌───────────── min (0 - 59)
# │ ┌────────────── hour (0 - 23)
# │ │ ┌─────────────── day of month (1 - 31)
# │ │ │ ┌──────────────── month (1 - 12)
# │ │ │ │ ┌───────────────── day of week (0 - 6) (0 to 6 are Sunday to Saturday, or use names; 7 is Sunday, the same as 0)
# │ │ │ │ │
# │ │ │ │ │
# * * * * *  command to execute

# put-scheduled-update-group-action
# --auto-scaling-group-name <value>
# --scheduled-action-name <value>
# [--time <value>]
# [--start-time <value>]
# [--end-time <value>]
# [--recurrence <value>]
# [--min-size <value>]
# [--max-size <value>]
# [--desired-capacity <value>]
# [--cli-input-json <value>]
# [--generate-cli-skeleton]

# NOTE: cannot use * because the shell interprets it and I can't figure out how to stop it

# set the capacity to 3 during normal working hours: 8AM to 5PM UTC Monday-Friday
SCALE_UP='aws autoscaling put-scheduled-update-group-action --auto-scaling-group-name ecs-autoscaling-experiment --scheduled-action-name scaleup-schedule-daily --recurrence "0 8 1-31 1-12 1-5" --min-size 1 --max-size 6 --desired-capacity 3'
echo $SCALE_UP
eval $SCALE_UP

# set the capacity to 0 during normal off hours: 5PM to 8AM UTC every day
SCALE_DOWN='aws autoscaling put-scheduled-update-group-action --auto-scaling-group-name ecs-autoscaling-experiment --scheduled-action-name scaledown-schedule-daily --recurrence "0 17 1-31 1-12 1-7" --min-size 0 --max-size 0 --desired-capacity 0'
echo $SCALE_DOWN
eval $SCALE_DOWN

