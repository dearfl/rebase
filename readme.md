# rebase

A simple github action that rebase and force push a branch.

## usage

If you have a branch containing some small changes you don't want to merge back into your default branch, but still want to keep it update to date, You often need to manually rebase it. With this action, you can write a simple workflow to automate this process.

A simple example:

```yml
name: Auto Rebase X11 branch

on:
  push:
    branches:
      - main
jobs:
  rebase:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - name: Auto Rebase X11 branch
        uses: dearfl/rebase@v1
        with:
          branch: x11
```

## License

This project is licensed under the GLWTPL (Good Luck With That Public License). See the `LICENSE` file for more details.
