# Installing Ruby, Rails

If you are using Windows, try and install Ubuntu (or your preferred
flavor of linux distributions). If that's not possible, consider
installing Ubuntu on a virtual machine as [discussed here](https://itsfoss.com/install-linux).

### In case you are using Mac OS,follow below commands
#### Install Xcode tools

Install Xcode from the MacApp Store if you haven't already.
[Refer this in case of any issues](https://stackoverflow.com/questions/9329243/xcode-install-command-line-tools)
#### Install HomeBrew
HomeBrew is a package manager for Mac and helps organise the packages you install.
Enter the following command in the terminal to install HomeBrew if you haven't already
`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
#### Install `gnupg`
```bash
brew install gnupg
```

## Below steps are common to Linux and MacOS
Install [Ruby Version Manager (RVM)](http://rvm.io/rvm/install). If
  you are using Ubuntu, using [the dedicated package](https://github.com/rvm/ubuntu_rvm) is the simplest way to install.

> RVM allows you to easily install, manage and work with multiple ruby
> environments.

- Install Ruby (2.7.2)

```bash
rvm install ruby-2.7.2
rvm --default use 2.7.2
```

- Create and use a gemset `session_<n>` where `n` is the session number.
  It is recommended to use a different 

```bash
rvm gemset create session_0
rvm use 2.7.2@session_0
```

> A `gemset` is an isolated ruby setup. For example, you can isolate two
> projects using Rails 5 and Rails 6 from each other using a gemset.

> NOTE: Always switch to the appropriate gemset when working on a
> project. You can use a [project rvmrc](https://rvm.io/workflow/rvmrc)
> to automate this process.

- Install Bundler (2.2.0) and Rails (6.1.0)

```bash
gem install bundler --version 2.2.0
gem install rails --version 6.1.0
```

> While you can use different version of Ruby, Bundler and Rails - we
> recommend using the provided versions as all exercies are created and
> tested with these particular versions.

- Check if the above steps worked correctly.

```bash
rvm --version
ruby --version    # 2.7.2
bundler --version # 2.2.0
rails --version   # 6.1.0
```

If everything is installed correctly, you are ready to [get started with
Rails](/session_1/README.md).
