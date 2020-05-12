# Install to Linux Using gzip File

## Prerequisites

These prerequisites are for the host to which you're installing the Agent.

* Tasks

  Remove collector services such as `collectd`

  Remove third-party instrumentation and agent software
  **Note:**

  Do not use automatic instrumentation or instrumentation agents from
  other vendors when you're using SignalFx instrumentation. The results
  are unpredictable, but your instrumentation may break and your
  application may crash.

* Kernel version 2.6 or higher
* `CAP_DAC_READ_SEARCH` and `CAP_SYS_PTRACE` capabilities
* `terminal` or a similar command line interface application
* Permission to run `curl` and `sudo`
* `gzip`

## Steps

1. To get the latest `gzip` standalone installation package, navigate to
https://github.com/signalfx/signalfx-agent/releases, then download
`signalfx-agent-<latest_version>.tar.gz`.

For example, if the latest version is **5.1.6**:
- In the **releases** section, find the section entitled **v5.1.6**.
- In the **Assets** section, click `signalfx-agent-5.1.6.tar.gz
- The `gzip` file starts downloading.

2. To uncompress the package, run the following command:

`tar xzf signalfx-agent-<latest_version>.tar.gz`

The package expands into the directory `signalfx-agent`.

3. Navigate to the `signalfx-agent` directory:

`cd signalfx-agent`

4. To ensure that the binaries in the install files use the correct loader for your host, run
the following command:

`bin/patch-interpreter $(pwd)`

## Configuration

Create a configuration file for the agent:

* In a text editor, create the file `signalfx-agent/agent-config.yaml`
* In the file, add your host's hostname and port:
 `internalStatusHost: <local_hostname>`
 `internalStatusPort: <local_port>`
 `collectd:`
 `   configDir: <collectd_config_dir>`
* Save the file.

**NOTE:** The Smart Agent collects metrics based on the settings in
`agent-config.yaml`. `internalStatusHost` and `internalStatusPort`
specify the host and port number of the host that's running the Smart Agent.
`collectd.configDir` specifies the directory where the Smart Agent writes
`collectd` configuration files.

## Verification

### Start the Smart Agent

Start the Smart Agent by running this command:

`signalfx-agent/bin/signalfx-agent -config signalfx-agent/agent-config.yaml > <log_file>`

**NOTE:** The default log output for Smart Agent goes to `STDOUT` and `STDERR`.
To persist log output, direct the log output to `<log_file>` as shown in
the previous command.

### Verify the Smart Agent

To verify that your installation and config is working:

* For infrastructure monitoring:
  - In SignalFx UI, open the **Infrastructure** built-in dashboard
  - In the override bar at the top of the back, select **Choose a host**. Select one of your hosts from the dropdown.
  - The charts display metrics from your infrastructure.
 To learn more, see [Built-In Dashboards and Charts](https://docs.signalfx.com/en/latest/getting-started/built-in-content/built-in-dashboards.html).

* For Kubernetes monitoring:
  - In SignalFx UI, from the main menu select **Infrastructure** > **Kubernetes Navigator** > **Cluster map**.
  - In the cluster display, find the cluster you installed.
  - Click the magnification icon to view the nodes in the cluster.
  - The detail pane on the right hand side of the page displays details of your cluster and nodes.
  To learn more, see [Getting Around the Kubernetes Navigator](https://docs.signalfx.com/en/latest/integrations/kubernetes/get-around-k8s-navigator.html)

* For APM monitoring:

To learn how to install, configure, and verify the Smart Agent for Microservices APM (**µAPM**), see
[Overview of Microservices APM (µAPM)](https://docs.signalfx.com/en/latest/apm2/apm2-overview/apm2-overview.html).





