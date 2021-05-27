# Go Grpc Template

## Prepare

https://github.com/tmrts/boilr

```bash
curl -sL https://github.com/tmrts/boilr/releases/download/0.3.0/install | bash -s
$HOME/bin/boilr init
git clone https://github.com/hawickhuang/go-grpc-template.git
$HOME/bin/boilr template save go-grpc-template go-grpc-template
```

## Create project

```bash
mkdir -p $GOPATH/src/$RepoBase/$RepoGroup
cd $GOPATH/src/$RepoBase/$RepoGroup
$HOME/bin/boilr template use go-grpc-template $my_project
```
