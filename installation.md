# Installing Ruby, Rails

## Installing Ubuntu

If you are using Windows, try and dual boot the LTS version of Ubuntu
(that is, Ubuntu 20.04) or your preferred flavor of Linux distributions. 
_Dual boooting_ installs multiple operating systems - in this case,
Windows and Ubuntu. Every time you power on your device, you can decide
the operating system you want to use.

If that's not possible, consider installing Ubuntu on a virtual machine.
By using a Virtual Machine, you can run Ubuntu within Windows like any
other application.

> Using a Virtual Machine can be slow, especially if you allocate less
> than 4 GB RAM. Try dual-booting in such cases.

- [Download ISO for Ubuntu 20.04](http://www.releases.ubuntu.com/20.04/).
- [How To Install Ubuntu 20.04](https://itsfoss.com/install-linux).
- [How To Install Ubuntu Alongside Windows in Dual-Boot](https://www.tecmint.com/install-ubuntu-alongside-with-windows-dual-boot/).

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
Install [Ruby Version Manager (RVM)](http://rvm.io/rvm/install).
You can install RVM by running the following commands:
```bash
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable
```
You can also install the [ubuntu apt package](https://github.com/rvm/ubuntu_rvm), but the process is quite complex if messed up. We recommend you to install it by following the commands mentioned above.

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
* Finally, you'll need `Node.js` and `Yarn` installed to manage your application's JavaScript. So you can install `nodejs` by running the following command:
```bash
sudo apt install nodejs
```
* We need `yarn` for `webpacker` which is the Rails version of `webpack`. `webpack` is used to compile your application's JavaScript that's placed in `app/javascript`. To [install yarn](https://classic.yarnpkg.com/en/docs/install/#debian-stable) run the following commands:
```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
```
If everything is installed correctly, you are ready to [get started with
Rails](/session_1/README.md).
