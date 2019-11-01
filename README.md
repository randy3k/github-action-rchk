# GitHub Action running rchk for an R package

Just put this in your workflow

```yml
  rchk:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: randy3k/github-action-rchk@v1.0.0
      with:
        apt: <any apt-get dependencies>
        package: <your R package name>
```
