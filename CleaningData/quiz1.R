setwd("/home/arxwn/Repositories/datasciencecoursera/CleaningData/")
## Question 1
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# What time was it created? 
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio. 
install.packages("httr");
library(httr);
# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
# Use any URL you would like for the homepage URL (http://github.com is fine)
# and http://localhost:1410 as the callback url
#
# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", "24892f747a02cbeb031c", secret ="6feaa86b5a44572760bbbe28965ed33b3523e315")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

##"https://api.github.com/users/jtleek/repos"
# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

# {
#   "id": 4772877,
#   "name": "datascientist",
#   "full_name": "jtleek/datascientist",
#   "owner": {
#     "login": "jtleek",
#     "id": 1571674,
#     "avatar_url": "https://avatars.githubusercontent.com/u/1571674?v=3",
#     "gravatar_id": "",
#     "url": "https://api.github.com/users/jtleek",
#     "html_url": "https://github.com/jtleek",
#     "followers_url": "https://api.github.com/users/jtleek/followers",
#     "following_url": "https://api.github.com/users/jtleek/following{/other_user}",
#     "gists_url": "https://api.github.com/users/jtleek/gists{/gist_id}",
#     "starred_url": "https://api.github.com/users/jtleek/starred{/owner}{/repo}",
#     "subscriptions_url": "https://api.github.com/users/jtleek/subscriptions",
#     "organizations_url": "https://api.github.com/users/jtleek/orgs",
#     "repos_url": "https://api.github.com/users/jtleek/repos",
#     "events_url": "https://api.github.com/users/jtleek/events{/privacy}",
#     "received_events_url": "https://api.github.com/users/jtleek/received_events",
#     "type": "User",
#     "site_admin": false
#   },
#   "private": false,
#   "html_url": "https://github.com/jtleek/datascientist",
#   "description": "datascientist",
#   "fork": false,
#   "url": "https://api.github.com/repos/jtleek/datascientist",
#   "forks_url": "https://api.github.com/repos/jtleek/datascientist/forks",
#   "keys_url": "https://api.github.com/repos/jtleek/datascientist/keys{/key_id}",
#   "collaborators_url": "https://api.github.com/repos/jtleek/datascientist/collaborators{/collaborator}",
#   "teams_url": "https://api.github.com/repos/jtleek/datascientist/teams",
#   "hooks_url": "https://api.github.com/repos/jtleek/datascientist/hooks",
#   "issue_events_url": "https://api.github.com/repos/jtleek/datascientist/issues/events{/number}",
#   "events_url": "https://api.github.com/repos/jtleek/datascientist/events",
#   "assignees_url": "https://api.github.com/repos/jtleek/datascientist/assignees{/user}",
#   "branches_url": "https://api.github.com/repos/jtleek/datascientist/branches{/branch}",
#   "tags_url": "https://api.github.com/repos/jtleek/datascientist/tags",
#   "blobs_url": "https://api.github.com/repos/jtleek/datascientist/git/blobs{/sha}",
#   "git_tags_url": "https://api.github.com/repos/jtleek/datascientist/git/tags{/sha}",
#   "git_refs_url": "https://api.github.com/repos/jtleek/datascientist/git/refs{/sha}",
#   "trees_url": "https://api.github.com/repos/jtleek/datascientist/git/trees{/sha}",
#   "statuses_url": "https://api.github.com/repos/jtleek/datascientist/statuses/{sha}",
#   "languages_url": "https://api.github.com/repos/jtleek/datascientist/languages",
#   "stargazers_url": "https://api.github.com/repos/jtleek/datascientist/stargazers",
#   "contributors_url": "https://api.github.com/repos/jtleek/datascientist/contributors",
#   "subscribers_url": "https://api.github.com/repos/jtleek/datascientist/subscribers",
#   "subscription_url": "https://api.github.com/repos/jtleek/datascientist/subscription",
#   "commits_url": "https://api.github.com/repos/jtleek/datascientist/commits{/sha}",
#   "git_commits_url": "https://api.github.com/repos/jtleek/datascientist/git/commits{/sha}",
#   "comments_url": "https://api.github.com/repos/jtleek/datascientist/comments{/number}",
#   "issue_comment_url": "https://api.github.com/repos/jtleek/datascientist/issues/comments/{number}",
#   "contents_url": "https://api.github.com/repos/jtleek/datascientist/contents/{+path}",
#   "compare_url": "https://api.github.com/repos/jtleek/datascientist/compare/{base}...{head}",
#   "merges_url": "https://api.github.com/repos/jtleek/datascientist/merges",
#   "archive_url": "https://api.github.com/repos/jtleek/datascientist/{archive_format}{/ref}",
#   "downloads_url": "https://api.github.com/repos/jtleek/datascientist/downloads",
#   "issues_url": "https://api.github.com/repos/jtleek/datascientist/issues{/number}",
#   "pulls_url": "https://api.github.com/repos/jtleek/datascientist/pulls{/number}",
#   "milestones_url": "https://api.github.com/repos/jtleek/datascientist/milestones{/number}",
#   "notifications_url": "https://api.github.com/repos/jtleek/datascientist/notifications{?since,all,participating}",
#   "labels_url": "https://api.github.com/repos/jtleek/datascientist/labels{/name}",
#   "releases_url": "https://api.github.com/repos/jtleek/datascientist/releases{/id}",
#   "created_at": "2012-06-24T14:36:20Z",
#   "updated_at": "2015-01-15T03:58:56Z",
#   "pushed_at": "2012-06-24T14:38:18Z",
#   "git_url": "git://github.com/jtleek/datascientist.git",
#   "ssh_url": "git@github.com:jtleek/datascientist.git",
#   "clone_url": "https://github.com/jtleek/datascientist.git",
#   "svn_url": "https://github.com/jtleek/datascientist",
#   "homepage": null,
#   "size": 98,
#   "stargazers_count": 6,
#   "watchers_count": 6,
#   "language": "R",
#   "has_issues": true,
#   "has_downloads": true,
#   "has_wiki": true,
#   "has_pages": false,
#   "forks_count": 16,
#   "mirror_url": null,
#   "open_issues_count": 0,
#   "forks": 16,
#   "open_issues": 0,
#   "watchers": 6,
#   "default_branch": "master"
# },

##################################################################
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery 
# command in RMySQL. Download the American Community Survey data and load it into an R object called 
#
# Which of the following commands will select only the data for the probability 
# weights pwgtp1 with ages less than 50?
#
# sqldf("select pwgtp1 from acs where AGEP < 50")
# sqldf("select * from acs")
# sqldf("select pwgtp1 from acs")
# sqldf("select * from acs where AGEP < 50 and pwgtp1")

install.packages("sqldf");
library(sqldf);

acs <- read.csv(file="Repositories/datasciencecoursera/CleaningData/getdata_data_ss06pid.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

################################################################3
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")
################################################################
# How many characters are in the 10th, 20th, 30th and 100th 
# lines of HTML from this page: 
# http://biostat.jhsph.edu/~jleek/contact.html 
install.packages("XML")
library(XML)
library(httr)
htmlData <- GET("http://biostat.jhsph.edu/~jleek/contact.html")
htmlContent <- content(htmlData)
################################################################
t <- read.csv("getdata_wksst8110.for")
