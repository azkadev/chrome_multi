# Chrome Mult


```bash
git clone https://github.com/azkadev/chrome_multi.git
```

```bash
cd chrome_multi
```

```bash
dart pub get
dart compile exe ./bin/chrome_multi.dart -o ./linux/packaging/usr/local/bin/chrome_multi
dart pub run packagex build
```

```bash
sudo dpkg --force-all -i ./build/chrome_multi-linux.deb
```


```bash
chrom_multi -name your_name
```