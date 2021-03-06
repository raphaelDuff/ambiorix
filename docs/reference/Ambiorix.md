# Ambiorix

## Description

Web server class.

## Fields

- `not_found` 404 Response, must be a handler function that accepts the request and the response, by default uses [response_404()].
- `is_running` Boolean indicating whether the server is running.
- `error` 500 response when the route errors, must a handler function that accepts the request and the response, by default uses [response_500()].
- `on_stop` Callback to run when the server stops running; takes no argument.

## Methods

### Constructor

Instantiate an app.

- `host`: A string defining the host, defaults to `0.0.0.0`.
- `port`: Port to use, defaults to `getOption("ambiorix.port", NULL)`, if `NULL` uses a random port.

```r
Ambiorix$new(port = 5000L)
```

### Get, post, put, delete, and patch 

Add routes

- `path`: Path to check, when found runs `handler`.
- `handler`: Callback function that _must_ accept two arguments `req`, and `res`. The former is the request, the latter the response.
- `error`: A handler function to run when the `handler` errors, if none is specified then the global error is used instead (see [errors](/guide/errors)).

```r
app$get("/", function(req, res){
  res$send("Welcome!")
})
```

### Details

The handlers must return either 1) a response or 2) a promise which itself returns a response, see [async](/guide/async).

### Set 404

Define view for 404 error.

- `handler`: Callback function that _must_ accept two arguments `req`, and `res`. The former is the request, the latter the response.

```r
app$set_404(function(req, res){
  res$send("Not found", status = 404L)
})
```

### Static Files

Serves static files.

- `path`: Path to the static directory.
- `uri`: URL path where to server the static directory.

```r
# <script src="www/script.js"></script>
app$static("path/to/static files", "www")
```

### Websocket

Receive and respond to websocket messages.

- `name`: Name of the message.
- `handler`: Callback function to handle the message, must accept the `message` as first argument and can optionally accept the websocket as second argument, useful to respond.

```r
app$receive("hello", function(msg, ws){
  print(msg)
  ws$send("bye", "Goodbye")
})
```

## Serialiser

Defines the serialiser to use internally, only use this if you are familiar with serialisation as this may lead to grave headaches.

- `handler`: Function to use to serialise, this function should only accept one argument: the object to serialise.

```r
app$serialiser(function(x){
  jsonlite::toJSON(x, dataframe = "columns", auto_unbox = TRUE)
})
```

### Start

Start the server

- `open`: Whether to open the homepage in the browser (or RStudio viewer).
- `auto_stop`: Whether to automatically kill the server.

```r
app$start()
```

### Stop

Stop the server

```r
app$stop()
```

### Listen

Specify port to listen on.

```r
app$listen(3000L)
```