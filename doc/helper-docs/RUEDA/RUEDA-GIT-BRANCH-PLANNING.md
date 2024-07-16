# Branch Planning


<figure class="image">
  <img src="../assets/gitflow-with-release-branche.svg" alt="Gitflow with Release branch"  width="800" height="514" />
  <figcaption>Gitflow with Release branch (credit: https://www.atlassian.com/)</figcaption>
</figure>



- This git flow is inspired by the [Gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow).
- Some tweaks have been made to adapt with the project development requirements.
- **Though our `master` branch is locked for syncing with the core [ppcg](https://repo.or.cz/ppcg.git) repo, we made a few tweaks.**
- **`develop` will be acting as like `master`, & `test` branch will act like `develop` branch.**
- **DONOT USE `--fast-forward` MERGE COMMITS, UNLESS YOU KNOW WHAT YOU ARE DOING.**

```sh

└── master (should be synced w/ ppcg)
    ├── how-to-setup-ppcg
    ├── setup-cjson-osl-ppcg
    └── setup-osl-json-rueda
        └── develop (master) # <== tagged w/ version (vX.X.X)
            ├── hotfix/vX.X.X-issue-name-X
            └── test (develop)
                ├── feature/name-1
                │   └── feature/name-2
                ├── feature-3
                └── release/v0.1.0
```

<figure class="image">
  <img src="../assets/gitflow-with-hotfix-branches.svg" alt="Gitflow with Release branch"  width="800" height="514" />
  <figcaption>Gitflow with Hotfix branch (credit: https://www.atlassian.com/)</figcaption>
</figure>


# Core workflow

- **A `test` branch (concept is `develop`) is created from `develop` (concept is `master`)**

- **`release/vX.X.X` branches are created from `test`**

- **`feature/name-x` branches are created from `test`**

- **When a `feature/name-x` is complete, it is merged into the `test` branch.** (receiver = `test`, incoming = `feature/feature-name-x`)

- **Once `test` branch has acquired enough features for a release (or a predetermined release date is approaching), you fork a `release/vX.X.X` branch off of `test` branch.**

- **Once it's ready to ship, the `release/vX.X.X` branch gets merged into `test` & `develop` (i.e. `master`). And `develop` branch is `tagged` with a version number (e.g. `vX.X.X`).** (receiver = `test`, `develop`. incoming = `release/vX.X.X`)

- **It’s important to merge back into `test`. Because the critical updates may have been added to the `release/vX.X.X` branch which needed to be accessible to new features in `test` branch. If your organization stresses code review, this would be an ideal place for a pull request.**

- **Maintenance or `hotfix` branches are used to quickly patch production releases. `hotfix/vX.X.X-issue-name-X` branches are a lot like `release/vX.X.X` branches and `feature/feature-name-x` branches except, they're based on `develop` (i.e. `master`) instead of `test`.**

- **As soon as the fix is complete, a new `release/vX.X.X` branch should be forked from `test` (i.e. `develop`). Then the `hotfix/vX.X.X-issue-name-X` should be merged into `develop`, `test` and `release/vX.X.X` branches. Finally the `develop` should be tagged with an updated version number.** (receiver = `develop`, `test`, `release/vX.X.X`. incoming = `hotfix/vX.X.X-issue-name-X`).











