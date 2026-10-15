> Source: https://agent-browser.dev/streaming



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Streaming


Copy for LLM


View Markdown


Stream the browser viewport via WebSocket for live preview or "pair browsing" where a human can watch and interact alongside an AI agent.

## <a href="#streaming" class="peer" data-card="">Streaming</a>

Every session automatically starts a WebSocket stream server on an OS-assigned port. The server streams viewport frames and accepts input events (mouse, keyboard, touch).

To bind to a specific port, set `AGENT_BROWSER_STREAM_PORT`:


``` m-0
AGENT_BROWSER_STREAM_PORT=9223 agent-browser open example.com
```


You can also manage streaming at runtime:


``` m-0
agent-browser stream status            # Show streaming state and bound port
agent-browser stream enable --port 9223  # Re-enable on a specific port
agent-browser stream disable           # Stop streaming for the session
```


`stream status` returns the enabled state, active port, browser connection state, and whether screencasting is active. `stream disable` tears the server down and removes the session's `.stream` metadata file.

Use <a href="/recording" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Video Recording</a> when you need a saved WebM or MP4 artifact instead of a live WebSocket stream. Recording requires `ffmpeg` on `PATH`.

## <a href="#runtime-status-response" class="peer" data-card="">Runtime status response</a>

`agent-browser stream status --json` returns data like:


``` m-0
{
  "enabled": true,
  "port": 9223,
  "connected": true,
  "screencasting": true
}
```


`connected` reports whether the daemon currently has a browser attached. `screencasting` reports whether frames are actively being produced for the stream server.

## <a href="#relationship-to-screencast-commands" class="peer" data-card="">Relationship to screencast commands</a>

`stream enable` creates the WebSocket server and keeps it available for the session. WebSocket clients then trigger live frame delivery automatically.

The lower-level `screencast_start` and `screencast_stop` commands still control explicit CDP screencasts directly. Use them when you want a screencast without the WebSocket runtime server.

## <a href="#websocket-protocol" class="peer" data-card="">WebSocket protocol</a>

Connect to `ws://localhost:9223` to receive frames and send input.

Frame encoding is set per daemon with `AGENT_BROWSER_STREAM_QUALITY` (0 to 100), `AGENT_BROWSER_STREAM_MAX_WIDTH` and `AGENT_BROWSER_STREAM_MAX_HEIGHT`. The live stream requests jpeg. An explicit `screencast_start` reconfigures the same underlying screencast, so a client can see the format change mid-stream. Width and height cap the frame and default to the session viewport. On a busy page at 1280x720, quality 80 costs about 54 KB per frame, quality 20 about 25 KB, and quality 20 at 640x360 about 9 KB.

Browser clients must load from `localhost`, `127.0.0.1`, `::1` or `file://`. Any other origin gets a 403 on the upgrade and needs a proxy.

### <a href="#frame-messages" class="peer" data-card="">Frame messages</a>

The server sends frame messages with base64-encoded images:


``` m-0
{
  "type": "frame",
  "seq": 41,
  "data": "<base64-encoded-jpeg>",
  "metadata": {
    "deviceWidth": 1280,
    "deviceHeight": 720,
    "pageScaleFactor": 1,
    "offsetTop": 0,
    "scrollOffsetX": 0,
    "scrollOffsetY": 0,
    "timestamp": 1785038682238
  }
}
```


`seq` is a monotonic frame id. It is what an ack pacing client echoes back, and it keeps climbing across browser relaunches so a long-lived client never sees an id go backwards.

`metadata.timestamp` is the capture time in epoch milliseconds. Comparing it against the clock when the frame is drawn gives the age of what is on screen, which is the number worth watching on a constrained link.

### <a href="#url-messages" class="peer" data-card="">URL messages</a>

On Chrome, the server sends URL updates for full-document, History API, and fragment navigation in the active tab's main frame:


``` m-0
{
  "type": "url",
  "url": "https://example.com/dashboard#activity",
  "timestamp": 1785038682238
}
```


Navigation inside child frames or background tabs does not emit a URL message or replace the active tab's cached URL.

### <a href="#status-messages" class="peer" data-card="">Status messages</a>

Connection and screencast status:


``` m-0
{
  "type": "status",
  "connected": true,
  "screencasting": true,
  "viewportWidth": 1280,
  "viewportHeight": 720
}
```


### <a href="#frame-delivery" class="peer" data-card="">Frame delivery</a>

Frames are delivered latest-first: the server holds only the newest frame and reads it at send time, so every frame produced while an earlier one is still being written is skipped instead of queued. The application never builds a backlog.

In the default push pacing the transport underneath still can: frames already accepted by the socket are delivered in order, so a client that stops reading entirely drains whatever the kernel buffered before the writer blocked. Ack pacing removes that window (see below). Status, console, and tab messages flow through a separate ordered channel, so they are never replaced by a newer message the way frames are. They are not unconditionally durable: a client that falls far enough behind can lag out of that channel and lose messages, so treat console output as a live feed rather than an audit log.

Input handling is independent of frame delivery. Each connection reads input on its own task, so clicks and keystrokes dispatch to the browser immediately even while a large frame is mid-write to a slow client. Events go to the browser without waiting for its reply, so a click stays responsive behind a burst of mouse moves, and ordering is preserved.

### <a href="#client-configuration" class="peer" data-card="">Client configuration</a>

A client can cap its own frame rate by sending a `config` message at any time:


``` m-0
{
  "type": "config",
  "maxFps": 10
}
```


`maxFps` caps how many frames per second the server sends to this client (1 to 120). Set `0` to remove the cap (the default). Each client controls its own rate; other connected clients are unaffected.

### <a href="#ack-pacing" class="peer" data-card="">Ack pacing</a>

Push pacing hands each frame to the socket as soon as the rate allows, so a client that stalls drains what the transport buffered. To get one frame at a time instead, opt into ack pacing:


``` m-0
{
  "type": "config",
  "pacing": "ack"
}
```


The server then keeps at most one frame in flight and waits for the client to acknowledge it:


``` m-0
{
  "type": "ack",
  "seq": 41
}
```


Every `frame` message carries a monotonic `seq`. Echo the id of the frame you finished rendering. While an ack is outstanding, newer frames replace each other in the server and never reach the socket, so a client that stalls for ten seconds and resumes receives the current page rather than ten seconds of history. This mirrors how Chrome paces its own screencast upstream with `Page.screencastFrameAck`.

Under ack pacing one frame is in flight at a time, so the rate is one frame per transfer plus one acknowledgement round trip. Both the link's bandwidth and its latency bound it, and a link whose bandwidth-delay product exceeds a single frame goes underused. That headroom is the cost of the freshness guarantee.

Ack pacing bounds one hop. With a proxy in the path, forward the renderer's acks; acks generated on receipt leave frames queued on the far side.

Acks are cumulative: acknowledging a newer id covers every older one, so a client that skips ids still unblocks delivery. A client that opts in and then stops acknowledging simply stops receiving frames, while status, tabs, url, and console keep flowing. Send `{"type":"config","pacing":"push"}` to return to the default.

`pacing` and `maxFps` are independent and compose: pacing bounds how much is in flight, `maxFps` bounds the rate. A preview on a constrained link usually wants both.

A `config` message cannot cover the connection's opening frame, because the server sends the most recent frame as soon as the client connects. To have pacing apply from the very first frame, declare it on the URL instead:


``` m-0
ws://127.0.0.1:<port>/?pacing=ack&maxFps=10
```


A `config` message sent later still wins. An unrecognized or unparsable value on the URL is ignored rather than failing the connection.

## <a href="#input-injection" class="peer" data-card="">Input injection</a>

Send input events to control the browser remotely. Mouse, keyboard, and touch input reset the daemon idle timer, so an actively controlled dashboard or streaming session is not shut down by the default timeout.

### <a href="#mouse-events" class="peer" data-card="">Mouse events</a>


``` m-0
// Click
{
  "type": "input_mouse",
  "eventType": "mousePressed",
  "x": 100,
  "y": 200,
  "button": "left",
  "clickCount": 1
}

// Release
{
  "type": "input_mouse",
  "eventType": "mouseReleased",
  "x": 100,
  "y": 200,
  "button": "left"
}

// Move
{
  "type": "input_mouse",
  "eventType": "mouseMoved",
  "x": 150,
  "y": 250
}

// Scroll
{
  "type": "input_mouse",
  "eventType": "mouseWheel",
  "x": 100,
  "y": 200,
  "deltaX": 0,
  "deltaY": 100
}
```


### <a href="#keyboard-events" class="peer" data-card="">Keyboard events</a>


``` m-0
// Key down
{
  "type": "input_keyboard",
  "eventType": "keyDown",
  "key": "Enter",
  "code": "Enter"
}

// Key up
{
  "type": "input_keyboard",
  "eventType": "keyUp",
  "key": "Enter",
  "code": "Enter"
}

// Type character
{
  "type": "input_keyboard",
  "eventType": "char",
  "text": "a"
}

// With modifiers (1=Alt, 2=Ctrl, 4=Meta, 8=Shift)
{
  "type": "input_keyboard",
  "eventType": "keyDown",
  "key": "c",
  "code": "KeyC",
  "modifiers": 2
}
```


### <a href="#touch-events" class="peer" data-card="">Touch events</a>


``` m-0
// Touch start
{
  "type": "input_touch",
  "eventType": "touchStart",
  "touchPoints": [{ "x": 100, "y": 200 }]
}

// Touch move
{
  "type": "input_touch",
  "eventType": "touchMove",
  "touchPoints": [{ "x": 150, "y": 250 }]
}

// Touch end
{
  "type": "input_touch",
  "eventType": "touchEnd",
  "touchPoints": []
}

// Multi-touch (pinch zoom)
{
  "type": "input_touch",
  "eventType": "touchStart",
  "touchPoints": [
    { "x": 100, "y": 200, "id": 0 },
    { "x": 200, "y": 200, "id": 1 }
  ]
}
```


## <a href="#programmatic-api" class="peer" data-card="">Programmatic API</a>

For advanced use, control streaming directly via the TypeScript API:


``` m-0
import { BrowserManager } from 'agent-browser';

const browser = new BrowserManager();
await browser.launch({ headless: true });
await browser.navigate('https://example.com');

// Start screencast with callback
await browser.startScreencast((frame) => {
  console.log('Frame:', frame.metadata.deviceWidth, 'x', frame.metadata.deviceHeight);
  // frame.data is base64-encoded image
}, {
  format: 'jpeg',  // or 'png'
  quality: 80,     // 0-100, jpeg only
  maxWidth: 1280,
  maxHeight: 720,
  everyNthFrame: 1
});

// Inject mouse event
await browser.injectMouseEvent({
  type: 'mousePressed',
  x: 100,
  y: 200,
  button: 'left',
  clickCount: 1
});

// Inject keyboard event
await browser.injectKeyboardEvent({
  type: 'keyDown',
  key: 'Enter',
  code: 'Enter'
});

// Inject touch event
await browser.injectTouchEvent({
  type: 'touchStart',
  touchPoints: [{ x: 100, y: 200 }]
});

// Check if screencasting
console.log('Active:', browser.isScreencasting());

// Stop screencast
await browser.stopScreencast();
```


## <a href="#use-cases" class="peer" data-card="">Use cases</a>

- **Pair browsing** - Human watches and assists AI agent in real-time
- **Remote preview** - View browser output in a separate UI
- **Recording** - Capture frames for video generation
- **Mobile testing** - Inject touch events for mobile emulation
- **Accessibility testing** - Manual interaction during automated tests


<a href="/webmcp" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">WebMCP</span></a><a href="/recording" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Video Recording</span></a>


