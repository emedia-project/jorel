# xrel

eXtanded Release assembler for Erlang/OTP Releases

## Configuration

* `output_dir` : Output directory (default: `_xrel`)
* `exclude_dirs` : Path to exclude (default: `_xrel`)
* `include_src` : Include sources in the release (default: false)
* `sys_config` : Path to the configuration file (default: none)
* `vm_args` : Path to the `vm.args` file to use (default: none)
* `generate_start_script` : Generate start script (default: true)
* `include_erts` : Include ERTS in the release (default: true)
* `lib_dirs` : List of directory to search apps (default: none) / TODO
* `providers` : Add providers (default: none)

## Providers

* `xrel_provider_tar` : Create a Tar archive
* `xrel_provider_zip` : Create a Zip archive

## Contributing

1. Fork it ( https://github.com/emedia-project/xrel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
