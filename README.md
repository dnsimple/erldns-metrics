# Metrics API for [erldns]

This app provides an HTTP API for gathering and querying metrics from an [erldns] server and presenting those metrics as JSON.

> [!NOTE]
> erldns_metrics is architected to run in the *same Erlang VM* as erldns, as it reads metrics from the runtime. This is why erldns is a dependency of this library, and gets started in [`erldns_metrics.app.src`](./src/erldns_metrics.app.src): it's useful for local development, so that starting erldns_metrics also starts erldns.
> In general, you might want to run erldns_metrics and erldns both as dependencies of an application that *you* control and deploy.

Here's an example script that shows how to get the output with `curl` and pass it through Python to format it in a pretty fashion. It assumes you have this API running on port `8082`.

```bash
curl -s http://localhost:8082/ -H "Accept: application/json" | python -mjson.tool
```

> [!IMPORTANT]
> Timing stats are given in microseconds.

## Configuration

Configure this application with the `metrics` key under the `erldns` application:

```erlang
[
  {erldns, [
      {metrics, [
        %% Port that the JSON HTTP API runs on.
        {port, 8082},
        %% Processes to collect metrics about (see erlang:process_info/1).
        {monitored_processes, [erldns_zone_cache, erldns_query_throttle]}
      ]}
  ]}
].
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

You'll need [erldns] running. erldns_metrics starts it on startup, so you just need to run this in the erldns_metrics repository:

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

## Formatting

If your editor doesn't automatically format Erlang code using [erlfmt](https://github.com/WhatsApp/erlfmt), run:

```bash
make format
```

[erldns]: https://github.com/dnsimple/erldns
