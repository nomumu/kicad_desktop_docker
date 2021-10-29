# kicad_desktop_docker
A package that builds docker image for KiCad using noVNC.

![image](https://user-images.githubusercontent.com/34224090/134472668-44e86380-3eb7-4ab2-8bb9-c19618cc00b0.png)  

## Overview
このソフトウェアはDockerコンテナ内にnoVNCアクセス可能なGNOMEデスクトップを起動し、KiCadの実行環境を提供します．

### System Requirements
実行するために必要な環境は次の通りです．

- Ubuntu 20.04
  - その他の環境では動作確認していません．
- Docker build & run 可能な環境
  - amd64環境
  - OpenGLに対応したPCを推奨します．
  - 10GB程度の空き容量(イメージ作成に必要)
- ブラウザ
  - Firefox,Chrome,Edge

### Software version
使用しているソフトウェアのバージョン情報です．

- Ubuntu
  - 20.04 (focal)
- [KiCad](https://www.kicad.org/)
  - 5.1 release ver
- [VirtualGL](https://www.virtualgl.org/)
  - 2.6.5
- [kicad-i18n](https://github.com/KiCad/kicad-i18n.git)
  - 5.1

## Build
次のようにdockerイメージを構築します．

```
$ git clone https://github.com/nomumu/kicad_desktop_docker.git
$ cd kicad_desktop_docker
kicad_desktop_docker$ docker build . -t kicad_desktop_docker
```

## Run
実行用のスクリプトでDocker環境を起動します．

### Command
実行用スクリプトを次のように実行します．
```
kicad_desktop_docker$ ./run.sh
```

`run.sh`と同じ階層にある`homedir`をデスクトップのHOMEディレクトリとしてマウントします．  
Docker内に`run.sh`を実行したユーザを作成して作業を行います．

### VNC
`run.sh`を実行したPCの15900ポートへブラウザからアクセスするとデスクトップ環境へ接続できます．  

```
http://192.168.x.xxx:15900/vnc.html
```

### Options
- 次のように引数を指定することが可能です．複数環境を起動したい場合などに使用して下さい  
`./run.sh <CONTAINER_NAME> <PORT_NUMBER>`
  - CONTAINER_NAME: dockerコンテナ名を指定します
  - PORT_NUMBER: デスクトップ接続用ポートを指定します

## KiCad
デスクトップ環境ではメニューからKiCadを起動することができます．  

![image](https://user-images.githubusercontent.com/34224090/134477367-350aadbf-d0b5-4e3b-b63c-4f8aa37847ab.png)  

動作確認を行いたい場合、`/usr/shara/kicad/demos/`にデモプロジェクトがインストールされているので利用して下さい．  

このDocker環境はVirtualGLを利用してKiCadの3D機能を処理するように設定されています．次のダイアログでは`アクセラレーターを有効化`を選択することが可能です．  

![image](https://user-images.githubusercontent.com/34224090/134478189-dfd1be81-d03b-4c8b-866b-c3d9aac868e9.png)  

保存が必要なライブラリは`/home/<your kicad user>/`以下に設置するよう適切に設定して下さい．  

![image](https://user-images.githubusercontent.com/34224090/134479151-e37f9623-1c78-4384-b6e0-fa06edac6d5b.png)  

## Save
Docker環境内の`/home/<your kicad user>/`以下に保存されたデータは維持されます．  
基板データなどの取り出しはマウントした`homedir`へ直接アクセスする運用が可能です．  

## Download
`/home/<your kicad user>/to_download/`の中に格納したファイルは`http://192.168.x.xxx:15900/download/`からダウンロードすることが可能です．ガーバーデータの取り出しなどに利用して下さい．  
このディレクトリの内容はDockerコンテナを停止すると削除されるため一時領域として扱って下さい．

## Tips
- F11などでフルスクリーンに切り替えると有効になるショートカットが増えるので有効活用して下さい
- 日本語キーボードの`全角/半角`キーで日本語入力が可能な設定を施しています
  - ファイル名や設計メモなどに利用して下さい
  - KiCad 5.1は日本語入力に対応していません
- 複数人数での接続に対応していますのでレビューなどにも有効活用して下さい
  - 画面のリサイズを複数接続で有効にすると最後のリサイズが反映されます
- 一部環境とブラウザの組み合わせでキーコードに処理に問題がある場合があります
  - Windows上のブラウザからのアクセスが最も安定します
- デスクトップ環境が不調になった場合には，保存が必要なファイルを退避してhomedirを作り直すと解消する可能性があります
- Dockerコンテナは次のコマンドで停止させることが可能です  
  `docker stop kicad_desktop`
