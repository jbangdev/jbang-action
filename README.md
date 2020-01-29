# jbang github action

Action is intended for quick and easily run java based scripts with [jbang](https://github.com/maxandersen/jbang).

## Inputs

## Outputs

## Example usage

Here it is assumed you have a jbang script called `createissue.java` in the root of your project.

```
on: [push]

jobs:
    jbang:
      runs-on: ubuntu-latest
      name: A job to run jbang
      steps:
      - name: checkout
        uses: actions/checkout@v1
      - uses: actions/cache@v1
        with:
          path: /root/.jbang
          key: ${{ runner.os }}-jbang-${{ hashFiles('*.java') }}
          restore-keys: |
            ${{ runner.os }}-jbang-
      - name: jbang
        uses: maxandersen/jbang-action@v3
        with:
          script: createissue.java
          args: "my world"
        env:
          JBANG_REPO: /root/.jbang/repository
          GITHUB_TOKEN: ${{ secrets.ISSUE_GITHUB_TOKEN }}
```
