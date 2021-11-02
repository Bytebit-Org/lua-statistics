import toml

wally_manifest = toml.load('wally.toml')
print(wally_manifest['package']['version'], end='')
