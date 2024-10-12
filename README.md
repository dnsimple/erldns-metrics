# Metrics API for [erldns](https://github.com/dnsimple/erldns)

This app provides an HTTP API for gathering and querying metrics from an erldns server and presenting those metrics as JSON.

Here's an example script that shows how to get the output with `curl` and pass it through Python to format it in a pretty fashion. It assumes you have this API running on port `8082`.

```bash
curl -s http://localhost:8082/ -H "Accept: application/json" | python -mjson.tool
```

> [!IMPORTANT]
> Timing stats are given in microseconds.

## Configuration

To configure the metrics API port, add something like the following to your Erlang configuration section:

```erlang
[
  {erldns,[
      {metrics, [
        {port, 8082}
      ]},
    ]}
]
```

## Building

To build:

```bash
make
```

To start fresh:

```bash
make fresh
```

## Running

You'll need [erldns]() running. Then, you can run erldns_metrics as:

```bash
rebar3 shell
```

If you need to configure erldns (such as to use a different port), you can store configuration such as the one below in a file such as `erldns_metrics.config`:

```erlang
[
    {erldns, [
        {servers, [
            [
                {name, inet_localhost_1},
                {address, "127.0.0.1"},
                {port, 8053},
                {family, inet},
                {processes, 2}
            ],
            [{name, inet6_localhost_1}, {address, "::1"}, {port, 8053}, {family, inet6}]
        ]}
    ]}
].
```

Then, you can run erldns_metrics as:

```bash
rebar3 shell --config erldns_metrics.config
```

## Testing

```bash
make test
```
