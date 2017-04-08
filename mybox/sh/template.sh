# コマンドの有無は今後よく使うので
has() {
  type "$1" > /dev/null 2>&1
}
# 関数を作って、こんな風に使いましょう
if has "brew"; then
  ...
fi