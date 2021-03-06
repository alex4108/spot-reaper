
# Spot Reaper

[![GitHub issues](https://img.shields.io/github/issues/alex4108/spot-reaper)](https://github.com/alex4108/spot-reaper/issues)
[![GitHub forks](https://img.shields.io/github/forks/alex4108/spot-reaper)](https://github.com/alex4108/spot-reaper/network)
[![GitHub stars](https://img.shields.io/github/stars/alex4108/spot-reaper)](https://github.com/alex4108/spot-reaper/stargazers)
![GitHub contributors](https://img.shields.io/github/contributors/alex4108/spot-reaper)
[![GitHub license](https://img.shields.io/github/license/alex4108/spot-reaper)](https://github.com/alex4108/spot-reaper/blob/master/LICENSE)
![GitHub All Releases](https://img.shields.io/github/downloads/alex4108/spot-reaper/total)

Spot Reaper is the **PANIC!** button that the OS presses when an [AWS Spot Instance Termination Notificaiton](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-interruptions.html#spot-instance-termination-notices) arrives.

## Installation

```
git clone https://www.github.com/alex4108/spot-reaper.git
sudo bash spot-reaper/install.sh
```

Spot Reaper will install to sysvinit (service) or systemd (systemctl) so you can stop/start it through the appropriate interface.

Once it's installed, put your handler script at `/etc/spot-reaper/handler` and ensure root has executible permission.

## Management

### Systemd

```
systemctl enable spot-reaper
systemctl start spot-reaper
systemctl status spot-reaper
```

### Sysvinit

```
chkconfig spot-reaper on
service spot-reaper start
```


## Details

Spot Reaper will run as a system service and monitor for spot termination notifications.

When a new spot termination arrives, the reaper will execute `/etc/spot-reaper/handler`.  You can use this to implement any actions to take in the event a spot termination is about to arrive.

