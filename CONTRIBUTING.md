# Contribution Guidelines

## Pull requests are always welcome

We are always thrilled to receive pull requests, and do our best to
process them as fast as possible. Not sure if that typo is worth a pull
request? Do it! We will appreciate it.

If your pull request is not accepted on the first try, don't be
discouraged! If there's a problem with the implementation, hopefully you
received feedback on what to improve.

- [General Conventions](#general-conventions)
- [Development Setup](#development-setup)
    - [Viewing the site locally](#view-site-locally)
    - [Making CSS changes via LESS](#css-changes-are-done-with-less)
- [Sign your work](#sign-your-work)

## General Conventions

Fork the repo and make changes on your fork in a feature branch:

- If it's a bugfix branch, name it XXX-something where XXX is the number of the
  issue
- If it's a feature branch, create an enhancement issue to announce your
  intentions, and name it XXX-something where XXX is the number of the issue.

Pull requests descriptions should be as clear as possible and include a
reference to all the issues that they address.

Pull requests must not contain commits from other users or branches.

Commit messages must start with a capitalized and short summary (max. 50
chars) written in the imperative, followed by an optional, more detailed
explanatory text which is separated from the summary by an empty line.

When you open a pull request [netlify](https://netlify.com] will build your
branch and then you will be able to view the changes to the site **IN** your
pull request via a [deploy preview](https://www.netlify.com/blog/2016/07/20/introducing-deploy-previews).

Code review comments may be added to your pull request. Discuss, then make the
suggested modifications and push additional commits to your feature branch. Be
sure to post a comment after pushing. The new commits will show up in the pull
request automatically, but the reviewers will not be notified unless you
comment.

Before the pull request is merged, make sure that you squash your commits into
logical units of work using `git rebase -i` and `git push -f`. After every
commit the test suite should be passing. Include documentation changes in the
same commit so that a revert would remove all traces of the feature or fix.

Commits that fix or close an issue should include a reference like `Closes #XXX`
or `Fixes #XXX`, which will automatically close the issue when merged.

Changes to content should be separate from overall functionality. "Content"
means anything inside the `content/...` directory. Changes to content should be
submitted as a separate PR from changes to site functionality.

## Development Setup
1. Docker.
1. Fork this repo.

### View site locally
To watch for changes and rebuild on the fly, open a new terminal, cd to your
fork of the repo, and enter this command:
```console
$ make serve
```

You can then view the site at http://localhost:1337.

### CSS changes are done with LESS

Please do NOT make changes to any of the files in the `static/css` directory.
These are files that are compiled via LESS, and while your changes in there
might work, they will be blown away by the LESS compiler at some point.

If you want to make changes to CSS, you will need `docker` on your system so you
cn use Jess' awesome [`Makefile`](Makefile).

The only place to make changes to the LESS files is in
[`static/less/variables.less`](static/less/variables.less),
[`static/less/main.less`](static/less/main.less) and
[`static/less/custom.less`](static/less/custom.less).

*DO NOT* make any changes to any other LESS file (do not directly modify the
bootstrap LESS files, for example).

To use the `Makefile` it's as simple as:

```console
$ make
```
## Sign your work

The sign-off is a simple line at the end of the explanation for the
patch, which certifies that you wrote it or otherwise have the right to
pass it on as an open-source patch.  The rules are pretty simple: if you
can certify the below (from
[developercertificate.org](http://developercertificate.org/)):

```
Developer Certificate of Origin
Version 1.1

Copyright (C) 2004, 2006 The Linux Foundation and its contributors.
660 York Street, Suite 102,
San Francisco, CA 94110 USA

Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.


Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```

then you just add a line to every git commit message:

    Signed-off-by: Joe Smith <joe@gmail.com>

using your real name (sorry, no pseudonyms or anonymous contributions.)

You can add the sign off when creating the git commit via `git commit -s`.
