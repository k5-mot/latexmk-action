# latexmk-action

## Features

GitHub Action for compiling TeX files & generating PDF file.

## Usage

### Input arguments

|Arguments|Contents           |Required|default |
|:--:|:--:|:--:|:--:|
|ROOTFILE |Root file for LaTeX|Required|main.tex|

### GitHub Actions

This repository has Workflow of GitHub Actions.

The Workflow is releasing a PDF file from TeX files 
when you push tag to your repository.

```zsh
# Registry a location of remote repository.
git remote add origin git@github.com:[username]/[repository].git

# Label tag name.
git tag [tag_name(cf: v1.0.0)]

# Push tag to remote repository.
git push origin [tag_name]

# Release a PDF file in GitHub Releases.
```

## Example

Write down this file in your repository.

```yaml:.github/workflows/ubuntu-test.yml
name: 'ubuntu-test'

on:
  push:
    tags:
      - 'v*'

jobs:
  test_job:
    runs-on: ubuntu-latest
    name: 'demo'
    steps:
      - name: 'Set up Git repository'
        uses: actions/checkout@v2

      - name: 'info-action'
        id: info_action
        uses: k5-mot/info-action@main

      - name: 'latexmk-action'
        id: latexmk_action
        uses: k5-mot/latexmk-action@main
        with:
          ROOTFILE: 'main.tex'

      - name: 'package-action'
        id: package_action
        uses: k5-mot/package-action@main
        with: 
          RELEASE: 'release'
          EXCLUSIONS: '.git .vscode build' 

      - name: 'Create Release'
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: ${{ github.ref }}
          draft: false
          prerelease: false

      - name: 'Upload Release.pdf'
        id: upload_release_pdf
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: ./build/main.pdf
          asset_name: ${{ steps.info_action.outputs.release }}.pdf
          asset_content_type: application/pdf
          
      - name: 'Upload Release.tar.gz'
        id: upload_release_targz
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: ./release/release.tar.gz
          asset_name: ${{ steps.info_action.outputs.release }}.tar.gz
          asset_content_type: application/gzip

      - name: 'Upload Release.zip'
        id: upload_release_zip
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: ./release/release.zip
          asset_name: ${{ steps.info_action.outputs.release }}.zip
          asset_content_type: application/zip

```

## References

* [Docker コンテナのアクションを作成する](https://docs.github.com/ja/actions/creating-actions/creating-a-docker-container-action)
* [GitHub Actionsのワークフローコマンド](https://docs.github.com/ja/actions/reference/workflow-commands-for-github-actions)
* [GitHub Actions のコンテキストおよび式の構文](https://docs.github.com/ja/actions/reference/context-and-expression-syntax-for-github-actions)
* [複合実行ステップ アクションの作成](https://docs.github.com/ja/actions/creating-actions/creating-a-composite-run-steps-action)
* [Docker Hub texlive/texlive](https://hub.docker.com/r/texlive/texlive/)

## Note

Good luck!!!

## Author

* k5-mot

## License

Copyright (c) 2021 k5-mot All Rights Reserved.

"k5-mot/latexmk-action" is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).

