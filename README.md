## Metrics API for erldns

This app provides an HTTP API for gathering and querying metrics from an erldns server and presenting those metrics as JSON.

Here's an example script that shows how to get the output with curl and pass through Python to format it in a pretty fashion.

```bash
curl -s http://localhost:8082/ -H "Accept: application/json" | python -mjson.tool
```

Note that timing stats are givin in microseconds.

## Configuration

To configure the metrics API port, add something like the following to your erlang configuration section:

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
make
```

## Running

### To get an interactive Erlang REPL:

```bash
./rebar3 shell
```
