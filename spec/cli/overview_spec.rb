require 'spec_helper'

describe Travis::CLI::Overview do
  example 'overview branches' do
    run_cli('overview', 'branches', '-t', 'token').should be_success
    stdout.should be ==
      "passing builds in last 30 days\n" +
      "master: 67%\n" +
      "devel: 51%\n"
  end

  example 'overview branches no data' do
    run_cli('overview', 'branches', '-t', 'token', '-r', 'pypug/django-mango').should be_success
    stdout.should be == "passing builds in last 30 days\n"
    stderr.should include("no data")
  end

  example 'overview duration' do
    run_cli('overview', 'duration', '-t', 'token').should be_success
    stdout.should be ==
      "duration of last 20 builds\n" +
      "build 5 passed in 29 seconds\n" +
      "build 3 passed in 30 seconds\n" +
      "build 1 errored in 24 seconds\n"
  end

  example 'overview duration no data' do
    run_cli('overview', 'duration', '-t', 'token', '-r', 'pypug/django-mango').should be_success
    stdout.should be == "duration of last 20 builds\n"
    stderr.should include("no data")
  end

  example 'overview history' do
    run_cli('overview', 'history', '-t', 'token').should be_success
    stdout.should be ==
      "build statuses in last 10 days\n" +
      "2016-02-25:\n" +
      "   passed: 1\n" +
      "2016-03-01:\n" +
      "   canceled: 1\n"
  end

  example 'overview history no data' do
    run_cli('overview', 'history', '-t', 'token', '-r', 'pypug/django-mango').should be_success
    stdout.should be == "build statuses in last 10 days\n"
    stderr.should include("no data")
  end

  example 'overview eventType' do
    run_cli('overview', 'eventType', '-t', 'token').should be_success
    stdout.should be ==
      "statuses by event type\n" +
      "push:\n" +
      "   failed: 3\n" +
      "   errored: 1\n" +
      "pull_request:\n" +
      "   passed: 11\n" +
      "   errored: 1\n" +
      "cron:\n" +
      "   failed: 1\n" +
      "   canceled: 2\n"
  end

  example 'overview eventType no data' do
    run_cli('overview', 'eventType', '-t', 'token', '-r', 'pypug/django-mango').should be_success
    stdout.should be == "statuses by event type\n"
    stderr.should include("no data")
  end

  example 'overview streak' do
    run_cli('overview', 'streak', '-t', 'token').should be_success
    stdout.should be == "Your streak is 0 days and 0 builds.\n"
  end
end
