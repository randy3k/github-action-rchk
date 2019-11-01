# GitHub Action running rchk for an R package

Just put this in your workflow

```yml
  rchk:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: randy3k/github-action-rchk@master
      with:
        apt: <any apt dependencies>
        package: <R package name, optional>
```

Any `apt` dependencies could be installed by providing the `apt` argument. For example, `apt: libxml2-dev libssl-dev` etc.

The `package` is the optional package name. If left empty, it will be determined from the repo name.
