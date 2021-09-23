# kicad_desktop_docker
A package that builds docker image for KiCad using noVNC.

## Overview
このソフトウェアはDockerコンテナ内にnoVNCアクセス可能なGNOMEデスクトップを起動し、KiCadの実行環境を提供します．

## System Requirements
実行するために必要な環境は次の通りです．

- Ubuntu 20.04
  - その他の環境では動作確認していません．
- Docker build & run 可能な環境
  - amd64環境
  - OpenGLに対応したPCを推奨します．
  - 10GB程度の空き容量(イメージ作成に必要)

## Software version
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

```
kicad_desktop_docker$ ./run.sh
```

`run.sh`と同じ階層にある`homedir`をデスクトップのHOMEディレクトリとしてマウントします．  
Docker内に`run.sh`を実行したユーザを作成して作業を行います．

## Setting
起動時にDocker内でdbus-daemonを起動するためにsudoパスワードを要求されます．  
初回起動時のみVNC接続用のパスワード設定を行います．6文字以上のパスワードを設定して下さい．  

```
kicad_desktop_docker$ ./run.sh
[sudo] password for <your kicad user>:
 * Starting system message bus dbus                                                                                  [ OK ]

You will require a password to access your desktops.

Password:
Verify:
Would you like to enter a view-only password (y/n)?
```

## VNC
`run.sh`を実行したPCの15900ポートへブラウザアクセスするとVNC接続できます．  
パスワードを入力するとデスクトップで作業ができるようになります．

```
http://192.168.x.xxx:15900/vnc.html
```

## KiCad
メニューからKiCadを起動することができます．  
動作確認を行いたい場合、`/usr/shara/kicad/demos/`にデモプロジェクトがインストールされているので利用して下さい．  

## Save
Docker環境内の`/home/<your kicad user>/`以下に保存されたデータは維持されます．  
基板データなどの取り出しはマウントした`homedir`へ直接アクセスする運用が可能です．  




